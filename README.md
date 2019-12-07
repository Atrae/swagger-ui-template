# swagger-ui-template

- swaggerファイルをlocalで編集して、S3にデプロイし公開するためのテンプレートです

## 開始

- `docker-compose -f docker-compose.yml up -d` で環境を起動してください。
- `localhost:8000` にアクセスして、swagger-uiを確認してください。

## 編集

- `src/` 以下のファイルを編集・保存することで、`docs/index.yml` に反映されます。
- 利用環境に合わせて適宜ファイル分割してください。
- 分割したファイルは、`$ref: ./ファイルパス名` で読み込めます。

## 終了

- `docker-compose -f docker-compose.yml down` で環境を終了してください。


## デプロイ

### デプロイ先の構築

- `terraform init`, `terraform apply` でS3にバケットを構築します。
- S3の設定は適宜変更してください。
