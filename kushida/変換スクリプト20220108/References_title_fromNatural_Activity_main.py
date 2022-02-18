import re
import urllib.parse
import os
import pandas as pd

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

pattern03a=re.compile(r'\;') 
cal3_sep = [re.sub('\;', r'\n', x) for x in cal3]


# 検証用 save_file('Natural_Activity_main_cal3.tsv', "\n".join(cal3))
# 検証用 save_file('Natural_Activity_main_cal3_sep.tsv', "\n".join(cal3_sep))
#save_file('Natural_Activity_main02.tsv', "\n".join(lines))

###

# URLエンコード
cal3_url = [urllib.parse.quote(i, safe='\n') for i in cal3_sep]

pattern03=re.compile(r'(.+)') 
cal3_http = [re.sub('(.+)', r'<http://kanpsack/References/\1>\t<http://purl.org/dc/elements/1.1/title>', x) for x in cal3_url]

# 検証用 save_file('Natural_Activity_main_cal3_url.tsv', "\n".join(cal3_url))
save_file('Natural_Activity_main_cal3_http.tsv', "\n".join(cal3_http))

###

pattern03=re.compile(r'(.+)') 
cal3_leteral = [re.sub('(.+)', r'"\1" .', x) for x in cal3_sep]

save_file('Natural_Activity_main_cal3_literal.tsv', "\n".join(cal3_leteral))

###

# 改行や空白文字を削除
cal3_http = list(map(lambda x: x.strip(), cal3_http)) # mapでlistを作成
cal3_leteral = list(map(lambda x: x.strip(), cal3_leteral)) # .strip()で文頭，文末のスペース，改行を削除

# タブ区切りで並べたリストを作成 zipで複数のシーケンスオブジェクトを同時にループ
# 結合したカラムがずれるために，実行回避
##lines_ttl = ["{0}\t{1}".format(line1, line2) for line1, line2 in zip(cal3_http, cal3_leteral)]
##save_file('References_title_fromNatural_Activity_main.ttl', "\n".join(lines_ttl)) # .joinで，改行で'\n'で行を連結

# 代わりに，とりあえずcsvでカラムを結合
df1 = pd.read_csv('Natural_Activity_main_cal3_http.tsv')
df2 = pd.read_csv('Natural_Activity_main_cal3_literal.tsv')
df_concat = pd.concat([df1,df2],axis=1)
df_concat.to_csv('merged_cal3_http_leteral.csv', index=None)

ttl = read_file('merged_cal3_http_leteral.csv').split('\n') # .splitでlist
ttl = list(filter(lambda line: line != '', ttl))

# ttlにするために，余分な「,」の削除，「"」の修正
pattern44=re.compile(r'(\>)\,(\")') 
ttl = [re.sub('(\>)\,(\")', r'\1\t\2', x) for x in ttl]
pattern45=re.compile(r'\s\.\"$') 
ttl = [re.sub('\s\.\"$', r'" .', x) for x in ttl]

# ソート
ttl_sorted = sorted(ttl) # 並べ替え
ttl_set = set(ttl_sorted) # 重複削除

#save_file('References_title_fromNatural_Activity_main00.ttl', "\n".join(ttl))
#save_file('References_title_fromNatural_Activity_main01.ttl', "\n".join(ttl_sorted))
save_file('References_title_fromNatural_Activity_main.ttl', "\n".join(ttl_set))
###

# 参照: https://www.suzu6.net/posts/21/
# 参照: https://www.suzu6.net/posts/22/
