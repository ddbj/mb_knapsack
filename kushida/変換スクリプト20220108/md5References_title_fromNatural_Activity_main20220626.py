import re
import urllib.parse
import os
import pandas as pd
import hashlib

def read_file(file_name):
    with open(file_name, 'r') as file:
        return file.read()

def readlines_file(file_name):
    # 行毎のリストを返す
    with open(file_name, 'r') as file:
        return file.readlines()


def save_file(file_name, text):
    with open(file_name, 'w') as file:
        file.write(text)


lines = read_file('Natural_Activity_main_rev.tsv').split('\n') # .splitでstrからlist

# 空行の削除
lines = list(filter(lambda line: line != '', lines))

# 不要行の削除
pattern0=re.compile(r'sp\tactivity\treference') 
lines = [x for x in lines if re.sub('sp\tactivity\treference', r'', x)]
pattern00=re.compile(r'\(1432\srows\)') 
lines = [x for x in lines if re.sub('\(1432\srows\)', r'', x)]

# 指定列の取り出し
#cal1 = list(map(lambda line: line.split('\t')[0], lines))
cal3 = list(map(lambda line: line.split('\t')[2], lines))

# 複数の値（雑誌名）の区切り（;）記号を改行に変換
pattern03a=re.compile(r'\;') 
cal3_sep = [re.sub('\;', r'\n', x) for x in cal3]


###
"""
# URLエンコード
cal3_url = [urllib.parse.quote(i, safe='\n') for i in cal3_sep]
"""

###

# 雑誌名をリテラルとしてtsv保存
pattern03=re.compile(r'(.+)') 
cal3_leteral = [re.sub('(.+)', r'"\1"', x) for x in cal3_sep]

save_file('Natural_Activity_main_cal3_literal.tsv', "\n".join(cal3_leteral))

###

# 改行や空白文字を削除
cal3_leteral = list(map(lambda x: x.strip(), cal3_leteral)) # .strip()で文頭，文末のスペース，改行を削除





# タブ区切りで並べたリストを作成 zipで複数のシーケンスオブジェクトを同時にループしたが，
# 結合したカラムがずれるために，実行回避
##lines_ttl = ["{0}\t{1}".format(line1, line2) for line1, line2 in zip(cal3_http, cal3_leteral)]
##save_file('References_title_fromNatural_Activity_main.ttl', "\n".join(lines_ttl)) # .joinで，改行で'\n'で行を連結


# 代わりに，とりあえずcsvでカラムを結合
df1 = pd.read_csv('Natural_Activity_main_cal3_literal.tsv')
df2 = pd.read_csv('Natural_Activity_main_cal3_literal.tsv')
df_concat = pd.concat([df1,df2],axis=1)
df_concat = df_concat.drop_duplicates() #重複行の削除
df_concat.to_csv('merged_Natural_Activity_main_cal3_literal.tsv', sep='\t', index=False)

# tsvをリスト形式に変換
ttl = read_file('merged_Natural_Activity_main_cal3_literal.tsv').split('\n') # .splitでlist

# ソート（不要かも）
ttl_sorted = sorted(ttl) # 並べ替え
ttl_set = set(ttl_sorted) # 重複削除

# 検証用 save_file('ttl.txt', "\n".join(ttl))

# 空行の削除
ttl = list(filter(lambda line: line != '', ttl))

# 指定列の取り出し
cal1 = list(map(lambda line: line.split('\t')[0], ttl))
cal2 = list(map(lambda line: line.split('\t')[1], ttl))

# md5でハッシュ化（subject）
cal1_md5 = [hashlib.md5(i.encode('utf-8')).hexdigest() for i in cal1]
cal1_md5_title = [re.sub('(.+)', r'<http://purl.jp/knapsack/References/\1>\t<http://purl.org/dc/elements/1.1/title>', x) for x in cal1_md5]

# リテラル(object)
cal2_literal = [re.sub('(.+)', r'"\1" . ', x) for x in cal2]

# 検証用 save_file('cal1_md5.txt', "\n".join(cal1_md5))
# 検証用 save_file('cal2_literal.txt', "\n".join(cal2_literal))

# zip関数を使ってトリプル作成
xxx = ["{0}\t{1}".format(line1, line2) for line1, line2 in zip(cal1_md5_title, cal2_literal)]

# ソート
xxx_sorted = sorted(xxx) # 並べ替え
xxx_set = set(xxx_sorted) # 重複削除

save_file('md5References_title_fromNatural_Activity_main.ttl', "\n".join(xxx_set)) # .joinで，改行で'\n'で行を連結


# 参照: https://www.suzu6.net/posts/21/
# 参照: https://www.suzu6.net/posts/22/
