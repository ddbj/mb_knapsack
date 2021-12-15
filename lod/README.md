## タイトル
Shexerを利用したHigh-quality RDF生成の自動化を目指して

## 概要
一部の人類は、既存オントロジーや新規オントロジーを利用して既存のリソースのLOD化を繰り返し行っている。さらに自分の作ったLODと他人の作ったLODをデータ統合して、新しいサービスや知識を提供しようと努力を繰り返しているが、http/httpsの揺れや、同一のURIを意図しながら大文字・小文字の異なりが存在したり、あるいはつづりの誤りが存在したりするなど、同じリソースを示すURIが複数存在することで、繋がるはずのデータが繋がらず、結果としてRDFのキュレーションをするという苦行を繰り返し経験している。

LODはデータのウェブであり、複数の主体により構築されたデータが相互に参照しあうことで巨大な知識グラフが構成され、その価値が最大化される。その一方で、複数の主体が構築するからこそ、先述のような差異が生じてしまい、データのウェブが持つ本来の価値が毀損されてしまう。また、この問題は、人手による作業ではどうしても避けられないとの認識を我々は抱いており、機械による半自動化が必須であると考えている。

我々は、様々なLODとの接続が期待され、植物を中心とした代謝産物および文献知識に基づいた由来生物や生物活性情報などのアノテーションが集積されたNApSAcK familyデータベースのRDF化に取り組んでいる。当該RDFデータはオープンであり、他のデータセットへのリンクも含まれていることから、[星5つのオープンデータ](https://5stardata.info/)に近づいていると認識している。しかし、他のデータセットと確実に繋がるURIを含めることで、さらに価値の高まるオープンデータになると確信し、この、いわば星6つのHigh-qualityなRDFと呼べる段階に昇華させるための苦行の半自動化を目指して、これまでにないRDF洗練化アプローチを提案する。

## 提案
### RDFデータの洗練作業サイクル

1. 所望のRDFデータのサブセットか、あるいはドラフトバージョンを構築する。
2. 1.もしくは5.で用意したRDFデータセットに対して、当該データセットをひな形としたShExスキーマを、[`shexer`](https://github.com/DaniFdezAlvarez/shexer)を用いて生成する。ここで生成されたShExスキーマは、`shexer` に与えたRDFデータと同じデータ構造であることを検証するために利用する。
3. `shexer` を用いて生成されたShExスキーマを人手により確認し、例えば、特定のクラスに属するインスタンスURIが持つべき正規表現パターンの追加や不要なパターンの削除など、適宜加筆修正を行う。
4. 3.で編集されたShExスキーマを用いて、改めて所望のRDFデータを検証する。
5. 検証結果を踏まえ、必要であれば、RDFデータを編集したり、RDFデータ生成プログラムを改変してRDFデータを再構築したりして、2. に戻る。

上記の作業工程は下記の図のように表せる。なお、`shexer`は、与えられたRDFデータに基づき、当該RDFデータと同じデータ構造を持つことを検証するためのShExパターンを自動生成する。
Pythonモジュールとして公開されており、自身の作るプログラムから呼び出して利用可能である。

```
RDF（⭐️⭐️⭐️⭐️⭐️）←-----------------------------|
 ↓ shexer           ←---------------------|      |
ShEx Auto generation → Add/Edit schema ---|      | 
 ↓ rdf shex                                      |
RDF validation  → Add/Edit RDF ------------------|
 ↓
High-quality RDF （⭐️⭐️⭐️⭐️⭐️⭐️）
```

## 詳細

KNApSAcK RDFデータセットを利用して、shexerによるshex schemaの生成とおよびshex validationを実行した。

### shexerの実行
```
$ python gen_shex.py
```

### shex validationの実行

#### GUIの場合
https://rdfshape.weso.es/shExValidate?activeSchemaTab=%23schemaUrl&activeTab=%23dataUrl&dataFormat=TURTLE&dataFormatUrl=TURTLE&dataURL=https%3A%2F%2Fraw.githubusercontent.com%2Fddbj%2Fmb_knapsack%2Fmain%2FC00000001.ttl&endpoint=&inference=None&schemaEmbedded=false&schemaEngine=ShEx&schemaFormat=ShExC&schemaFormatUrl=ShExC&schemaURL=https%3A%2F%2Fraw.githubusercontent.com%2Fddbj%2Fmb_knapsack%2Fmain%2Flod%2Fknapsack_core.shex&shapeMap=%3Chttp%3A%2F%2Fmb-wiki.nig.ac.jp%2Fresource%2FC00000001%3E%40weso-s%3AKNApSAcKCoreRecord&shapeMapActiveTab=%23shapeMapTextArea&shapeMapFormat=Compact&shapeMapFormatTextArea=Compact&triggerMode=shapeMap

![Validate-RDF-data-with-ShEx](Validate-RDF-data-with-ShEx.png)


#### CUIの場合

既存のshex validation実装のテストおよびruby実装の試用

```
[tf@at044 lod]$ rdf shex knapsack_core_2021-08-28_exsample.ttl   --schema knapsack_core.shex --focus http://mb-wiki.nig.ac.jp/C00000001
ERROR Focus nodes with no start: expression: (schema (prefix (("rdf" <http://www.w3.org/1999/02/22-rdf-syntax-ns#>) ...
```

## 発展
今後の発展としては、上述のshexerを利用したRDFデータ洗練作業を一つのアプリケーション内で実施可能な統合環境の開発を行う。
また、ShExパターンによるRDFデータの検証結果を踏まえたメッセージを、次に行うべき作業が用意に想起できるように工夫する。
