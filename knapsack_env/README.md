
## 目的

KNApSAcK PostgreSQLダンプデータからデータ回収


## 環境
PostgreSQL 9.5構築
```
docker-compose up -d
```

## Dumpデータ投入

**TODO**
Dumpデータだけでは足りない、Database
docker-compose exec postgresql psql  < ../20210909遺伝研DDBJ/Metabolite_ACT.sql 
docker-compose exec postgresql psql  < ../20210909遺伝研DDBJ/skewer.sql 

## データ取得
TODO* SQLで
**TODO**
```
```
