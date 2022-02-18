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

lines = read_file('Metabolite_Activity.tsv').split('\n') # .splitでlist

# 空行の削除
lines = list(filter(lambda line: line != '', lines))

# 不要行の削除
pattern0=re.compile(r'cid\tmetabolite\tcategory\tfunction\ttargetsp\treference') 
lines = [x for x in lines if re.sub('cid\tmetabolite\tcategory\tfunction\ttargetsp\treference', r'', x)]
pattern00=re.compile(r'\(10758\srows\)') 
lines = [x for x in lines if re.sub('\(10758\srows\)', r'', x)]

# 検証用 save_file('Metabolite_Activity_lines.txt', "\n".join(lines))

# 指定列の取り出し
cal0_cid = list(map(lambda line: line.split('\t')[0], lines))
cal1_mtl = list(map(lambda line: line.split('\t')[1], lines))
cal2_cat = list(map(lambda line: line.split('\t')[2], lines))
cal3_fuc = list(map(lambda line: line.split('\t')[3], lines))
cal4_tag = list(map(lambda line: line.split('\t')[4], lines))
cal5_ref = list(map(lambda line: line.split('\t')[5], lines))

# cal0_cidの編集
pattern50 = re.compile(r'(.+)') 
cal0_cid = [re.sub('(.+)', r'<http://purl.org/dc/terms/identifier>\t"\1"', x) for x in cal0_cid]
# 検証用 save_file('Metabolite_Activity_cal0_cid.txt', "\n".join(cal0_cid))
#print(cal0_cid)

# cal1_mtlの編集
# URLエンコード
cal1_mtl_url = [urllib.parse.quote(i, safe='\n') for i in cal1_mtl]

pattern50 = re.compile(r'(.+)')
cal1_mtl_http = [re.sub('(.+)', r'<http://knapsack/Metabolite/\1>', x) for x in cal1_mtl_url]
# 検証用 save_file('Metabolite_Activity_cal1_mtl_http.txt', "\n".join(cal1_mtl_http))

pattern50 = re.compile(r'(.+)')
cal1_mtl_literal = [re.sub('(.+)', r'<http://www.w3.org/2000/01/rdf-schema#label>\t"\1"@en', x) for x in cal1_mtl]
# 検証用 save_file('Metabolite_Activity_cal1_mtl_literal.txt', "\n".join(cal1_mtl_literal))

# cal2_catの編集
pattern50 = re.compile(r'(.+)') 
cal2_cat = [re.sub('(.+)', r'<http://knapsack/property/category>\t"\1"', x) for x in cal2_cat]
# 検証用 save_file('Metabolite_Activity_cal2_cat.txt', "\n".join(cal2_cat))

# cal3_fucの編集
pattern50 = re.compile(r'(.+)') 
cal3_fuc = [re.sub('(.+)', r'<http://knapsack/property/function>\t"\1"', x) for x in cal3_fuc]
# 検証用 save_file('Metabolite_Activity_cal3_fuc.txt', "\n".join(cal3_fuc))

# cal4_tagの編集
pattern51 = re.compile(r'(.+\s*.*)\s*') 
cal4_tag = [re.sub('(.+\s*.*)\s*', r'<http://knapsack/property/targetsp>\t"\1"', x) for x in cal4_tag]
# 検証用 save_file('Metabolite_Activity_cal4_tag.txt', "\n".join(cal4_tag))
pattern52 = re.compile(r'(".+)\s(")$') 
cal4_tag = [re.sub('(".+)\s(")$', r'\1\2', x) for x in cal4_tag]
# 検証用 save_file('Metabolite_Activity_cal4_tag.txt', "\n".join(cal4_tag))

# cal5_refの編集
pattern50 = re.compile(r'(.+)') 
cal5_ref = [re.sub('(.+)', r'<http://knapsack/property/references>\t"\1"', x) for x in cal5_ref]
# 検証用 save_file('Metabolite_Activity_cal5_ref.txt', "\n".join(cal5_ref))

# 改行や空白文字を削除
#cal3_http = list(map(lambda x: x.strip(), cal3_http)) # mapでlistを作成
#cal3_leteral = list(map(lambda x: x.strip(), cal3_leteral)) # .strip()で文頭，文末のスペース，改行を削除

# タブ区切りで並べたリストを作成 zipで複数のシーケンスオブジェクトを同時にループ

### Metabolite_ActivityCateFunc_TargetSp_Ref.ttl を作成
#ttl_mcftr = ["{0}\t{1}\t{2}\t{3}\t{4}".format(line1, line2, line3, line4, line5) for line1, line2, line3, line4, line5 in zip(cal1_mtl_http, cal2_cat, cal3_fuc, cal4_tag, cal5_ref)]

ttl_mcftr = ["{0}\t{1} ;\t{2} ;\t{3} ;\t{4} .".format(line1, line2, line3, line4, line5) for line1, line2, line3, line4, line5 in zip(cal1_mtl_http, cal2_cat, cal3_fuc, cal4_tag, cal5_ref)]
save_file('Metabolite_ActivityCateFunc_TargetSp_Ref00.ttl', "\n".join(ttl_mcftr)) # .joinで，改行で'\n'で行を連結

ttl_mcftr_rev = read_file('Metabolite_ActivityCateFunc_TargetSp_Ref00.ttl').split('\n') # .splitでlist

# 文法エラー修正のために，余分な「;」の削除
pattern60=re.compile(r'>	 ;	<http://knapsack/property/function>') 
ttl_mcftr_rev = [re.sub('>	 ;	<http://knapsack/property/function>', r'>	<http://knapsack/property/function>', x) for x in ttl_mcftr_rev]

save_file('Metabolite_ActivityCateFunc_TargetSp_Ref.ttl', "\n".join(ttl_mcftr_rev))

### Metabolite_Label_cid.ttl を作成

ttl_mlc = ["{0}\t{1} ;\t{2} .".format(line1, line2, line3) for line1, line2, line3 in zip(cal1_mtl_http, cal1_mtl_literal, cal0_cid)]
# 検証用 save_file('Metabolite_Label_cid00.ttl', "\n".join(ttl_mlc)) # .joinで，改行で'\n'で行を連結

# 文法エラー修正のために，余分な「;」の削除
pattern61=re.compile(r';	 .') 
ttl_mlc_rev = [re.sub(';	 .', r'.', x) for x in ttl_mlc]

save_file('Metabolite_Label_cid.ttl', "\n".join(ttl_mlc_rev)) # .joinで，改行で'\n'で行を連結


###
# 上記で結合したカラムが「ずれる」場合は，
# 代わりに，以下のようにcsvでカラムを結合
#df1 = pd.read_csv('Natural_Activity_main_cal3_http.tsv')
#df2 = pd.read_csv('Natural_Activity_main_cal3_literal.tsv')
#df_concat = pd.concat([df1,df2],axis=1)
#df_concat.to_csv('merged_cal3_http_leteral.csv', index=None)

#ttl = read_file('merged_cal3_http_leteral.csv').split('\n') # .splitでlist
#ttl = list(filter(lambda line: line != '', ttl))

# ttlにするために，余分な「,」の削除，「"」の修正
#pattern44=re.compile(r'(\>)\,(\")') 
#ttl = [re.sub('(\>)\,(\")', r'\1\t\2', x) for x in ttl]
#pattern45=re.compile(r'\s\.\"$') 
#ttl = [re.sub('\s\.\"$', r'" .', x) for x in ttl]

#save_file('References_title_fromNatural_Activity_main00.ttl', "\n".join(ttl))
###

# 参照: https://www.suzu6.net/posts/21/
# 参照: https://www.suzu6.net/posts/22/
