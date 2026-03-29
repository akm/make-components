# ## firestore-emulator/test.mk
# テスト用 Firestore Emulator を Docker コンテナで自動起動・停止する。
# google/cloud-sdk:emulators イメージを使用し、起動後にヘルスチェック（最大30秒）で待機する。
#
# ## Requires:
# - docker: コンテナの起動・停止に使用
# - curl: エミュレータのヘルスチェックに使用
#
# ## Variables (overridable):
# - FIRESTORE_EMULATOR_PORT: ホスト側の公開ポート (default: 8280)
# - FIRESTORE_EMULATOR_CONTAINER: Docker コンテナ名 (default: uchimark-test-firestore)
# - FIRESTORE_EMULATOR_HOST_PORT: エミュレータへの接続先 (default: localhost:$(FIRESTORE_EMULATOR_PORT))
#
# ## Targets:
# - firestore-emulator-start: エミュレータが未起動の場合のみ起動する（冪等）
# - firestore-emulator-stop: エミュレータが起動中の場合のみ停止・削除する（冪等）

FIRESTORE_EMULATOR_PORT ?= 8280
FIRESTORE_EMULATOR_CONTAINER ?= uchimark-test-firestore
FIRESTORE_EMULATOR_HOST_PORT ?= localhost:$(FIRESTORE_EMULATOR_PORT)

.PHONY: firestore-emulator-start
firestore-emulator-start:
	@if ! docker ps --filter name=$(FIRESTORE_EMULATOR_CONTAINER) --filter status=running -q | grep -q .; then \
		echo "Starting Firestore emulator on port $(FIRESTORE_EMULATOR_PORT)..."; \
		docker run -d --name $(FIRESTORE_EMULATOR_CONTAINER) \
			-p $(FIRESTORE_EMULATOR_PORT):8080 \
			-e FIRESTORE_PROJECT_ID=uchimark-test \
			google/cloud-sdk:emulators \
			gcloud emulators firestore start --host-port=0.0.0.0:8080 > /dev/null 2>&1; \
		for i in $$(seq 1 30); do \
			if curl -sf http://$(FIRESTORE_EMULATOR_HOST_PORT)/ > /dev/null 2>&1; then \
				echo "Firestore emulator is ready"; \
				break; \
			fi; \
			sleep 1; \
		done; \
	fi

.PHONY: firestore-emulator-stop
firestore-emulator-stop:
	@if docker ps --filter name=$(FIRESTORE_EMULATOR_CONTAINER) -q | grep -q .; then \
		echo "Stopping Firestore emulator..."; \
		docker rm -f $(FIRESTORE_EMULATOR_CONTAINER) > /dev/null 2>&1; \
	fi
