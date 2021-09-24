## 目的

KNApSAcK PostgreSQLダンプデータからデータ回収

## 準備

```
mkdir -p postgres/init
mv ../20210909遺伝研DDBJ/Metabolite_ACT.sql postgres/init/
mv ../20210909遺伝研DDBJ/skewer.sql postgres/init/
```

## 環境
PostgreSQL 9.5構築

```
docker-compose up -d
```

## DB作成とDumpデータ投入
postgresqlコンテナに入る

```
docker-compose exec postgresql bash
```
コンテナ内で実行
```
root@postgres:/# createdb -U postgres Metabolite_Activity
root@postgres:/# createdb -U postgres Natural_Activity
root@postgres:/# psql -U postgres -d Metabolite_Activity < docker-entrypoint-initdb.d/Metabolite_ACT.sql 
root@postgres:/# psql -U postgres -d Natural_Activity <  docker-entrypoint-initdb.d/skewer.sql 

```

## データ取得

```
psql -h localhost -p 5432 -U postgres -d Metabolite_Activity  -c 'SELECT * FROM main_table;' -A -F "  " > Metabolite_Activity.tsv
psql -h localhost -p 5432 -U postgres -d Natural_Activity -c 'SELECT * FROM main' -A -F " " > Natural_Activity_main.tsv
psql -h localhost -p 5432 -U postgres -d Natural_Activity -c 'SELECT * FROM act_list' -A -F " " > Natural_Activity_act_list.tsv
psql -h localhost -p 5432 -U postgres -d Natural_Activity -c 'SELECT * FROM dictionary' -A -F " " > Natural_Activity_dictionary.tsv
```
