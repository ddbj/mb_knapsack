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

# cal0_cidの編集(e.g., C00004803)
pattern50 = re.compile(r'(.+)') 
cal0_dcid_cid = [re.sub('(.+)', r'<http://purl.org/dc/terms/identifier>\t"\1"', x) for x in cal0_cid]
# 検証用 save_file('Metabolite_Activity_cal0_dcid_id.txt', "\n".join(cal0_cid_id))
#print(cal0_cid)


# cal1_mtlの編集(e.g., 9,12,15-Octadecatrienoic acid, methyl)
"""
# URLエンコード
cal1_mtl_url = [urllib.parse.quote(i, safe='\n') for i in cal1_mtl]
"""

# md5
cal1_md5Mtl = [hashlib.md5(i.encode('utf-8')).hexdigest() for i in cal1_mtl]

cal1_httpMd5Mtl = [re.sub('(.+)', r'<http://purl.jp/knapsack/activity#\1>', x) for x in cal1_md5Mtl]
# 検証用 save_file('Metabolite_Activity_cal1_httpMd5Mtl', "\n".join(cal1_httpMd5Mtl))

cal1_label_mtl = [re.sub('(.+)', r'<http://www.w3.org/2000/01/rdf-schema#label>\t"\1"@en', x) for x in cal1_mtl]
# 検証用 save_file('Metabolite_Activity_cal1_label_mtl.txt', "\n".join(cal1_label_mtl))

cal1_label_eachMtl = [re.sub('\;', r'"@en , "', x) for x in cal1_label_mtl]
# 検証用 save_file('Metabolite_Activity_cal1_label_eachMtl.txt', "\n".join(cal1_label_eachMtl))



# cal2_catの編集(e.g., Antidermatitic)
# md5
cal2_md5Cat = [hashlib.md5(i.encode('utf-8')).hexdigest() for i in cal2_cat]

cal2_httpMd5Cat = [re.sub('(.+)', r'<http://purl.jp/knapsack/activity#\1>', x) for x in cal2_md5Cat]
# 検証用 save_file('Metabolite_Activity_cal2_httpMd5Cat ', "\n".join(cal2_httpMd5Cat))

cal2_categ_cat = [re.sub('(.+)', r'<http://purl.jp/knapsack/property/category>\t"\1"', x) for x in cal2_cat]
# 検証用 save_file('Metabolite_Activity_cal2_categ_cat.txt', "\n".join(cal2_categ_cat))

cal2_label_cat = [re.sub('(.+)', r'<http://www.w3.org/2000/01/rdf-schema#label>\t"\1"@en', x) for x in cal2_cat]
# 検証用 save_file('Metabolite_Activity_cal2_label_cat.txt', "\n".join(cal2_label_cat))




# cal3_fucの編集(e.g., Comedolytic)
# md5
cal3_md5Fuc = [hashlib.md5(i.encode('utf-8')).hexdigest() for i in cal3_fuc]

cal3_httpMd5Fuc = [re.sub('(.+)', r'<http://purl.jp/knapsack/activity#\1>', x) for x in cal3_md5Fuc]
# 検証用 save_file('Metabolite_Activity_cal3_httpMd5Fuc.txt', "\n".join(cal3_httpMd5Fuc))

cal3_func_fuc = [re.sub('(.+)', r'<http://purl.jp/knapsack/property/function>\t"\1"', x) for x in cal3_fuc]
# 検証用 save_file('Metabolite_Activity_cal3_func_fuc.txt', "\n".join(cal3_func_fuc))

cal3_label_fuc = [re.sub('(.+)', r'<http://www.w3.org/2000/01/rdf-schema#label>\t"\1"@en', x) for x in cal3_fuc]
# 検証用 save_file('Metabolite_Activity_cal3_label_fuc.txt', "\n".join(cal3_label_fuc))



# cal4_tagの編集(e.g., )
pattern51 = re.compile(r'(.+\s*.*)\s*') 
cal4_tag = [re.sub('(.+\s*.*)\s*', r'<http://purl.jp/knapsack/property/targetsp>\t"\1"', x) for x in cal4_tag]
# 検証用 save_file('Metabolite_Activity_cal4_tag.txt', "\n".join(cal4_tag))
pattern52 = re.compile(r'(".+)\s(")$') 
cal4_tag = [re.sub('(".+)\s(")$', r'\1\2', x) for x in cal4_tag]
# 検証用 save_file('Metabolite_Activity_cal4_tag.txt', "\n".join(cal4_tag))



# cal5_refの編集(e.g., Deepak et al.,American Journal of Advanced Drug Delivery,2(4),(2014),pp484-492)
pattern50 = re.compile(r'(.+)') 
cal5_ref = [re.sub('(.+)', r'<http://purl.jp/knapsack/property/references>\t"\1"', x) for x in cal5_ref]
# 検証用 save_file('Metabolite_Activity_cal5_ref.txt', "\n".join(cal5_ref))




# 改行や空白文字を削除
#cal3_http = list(map(lambda x: x.strip(), cal3_http)) # mapでlistを作成
#cal3_leteral = list(map(lambda x: x.strip(), cal3_leteral)) # .strip()で文頭，文末のスペース，改行を削除

# タブ区切りで並べたリストを作成 zipで複数のシーケンスオブジェクトを同時にループ

### Metabolite_ActivityCateFunc_TargetSp_Ref.ttl を作成
#ttl_mcftr = ["{0}\t{1}\t{2}\t{3}\t{4}".format(line1, line2, line3, line4, line5) for line1, line2, line3, line4, line5 in zip(cal1_mtl_http, cal2_cat, cal3_fuc, cal4_tag, cal5_ref)]


ttl_mcftr = ["{0}\t{1} ;\t{2} ;\t{3} ;\t{4} .".format(line1, line2, line3, line4, line5) for line1, line2, line3, line4, line5 in zip(cal1_httpMd5Mtl, cal2_categ_cat, cal3_func_fuc, cal4_tag, cal5_ref)]
# save_file('md5Metabolite_ActivityCateFunc_TargetSp_Ref00.ttl', "\n".join(ttl_mcftr)) # .joinで，改行で'\n'で行を連結

# ttl_mcftr_rev = read_file('md5Metabolite_ActivityCateFunc_TargetSp_Ref00.ttl').split('\n') # .splitでlist


# 文法エラー修正のために，余分な「;」の削除
pattern60=re.compile(r'>	 ;	<http://purl.jp/knapsack/property/function>') 
ttl_mcftr_rev = [re.sub('>	 ;	<http://purl.jp/knapsack/property/function>', r'>	<http://purl.jp/knapsack/property/function>', x) for x in ttl_mcftr]

# 主語がないトリプルの削除
ttl_mcftr_rev = [re.sub('^\t.+', r'', x) for x in ttl_mcftr_rev]
# 述語と目的語がないトリプルの削除
pattern2701=re.compile(r'^.+>[\t]*$') 
ttl_mcftr_rev = [re.sub('^.+>[\t]*$', r'', x) for x in ttl_mcftr_rev]

ttl_mcftr_rev = list(set(ttl_mcftr_rev)) # 重複削除
ttl_mcftr_rev = sorted(ttl_mcftr_rev) # 並べ替え

save_file('md5Metabolite_ActivityCateFunc_TargetSp_Ref.ttl', "\n".join(ttl_mcftr_rev))






### Metabolite_Label_cid.ttl を作成

ttl_mlc = ["{0}\t{1} ;\t{2} ;\t{3} .".format(line1, line2, line3, line4) for line1, line2, line3, line4 in zip(cal1_httpMd5Mtl, cal1_label_mtl, cal1_label_eachMtl, cal0_dcid_cid)]
# save_file('md5Metabolite_Label_cid00.ttl', "\n".join(ttl_mlc)) # .joinで，改行で'\n'で行を連結

"""
# 文法エラー修正のために，余分な「;」の削除
pattern61=re.compile(r'"(.+);') 
ttl_mlc_rev = [re.sub('"(.+);', r'".+;', x) for x in ttl_mlc]
"""

# 文法エラー修正のために，余分な「;」の削除
pattern2022062501=re.compile(r';     .') 
ttl_mlc_rev = [re.sub(';     .', r'.', x) for x in ttl_mlc]


# 主語がないトリプルの削除
ttl_mlc_rev = [re.sub('^\t.+', r'', x) for x in ttl_mlc_rev]
# 述語と目的語がないトリプルの削除
pattern2701=re.compile(r'^.+>[\t]*$') 
ttl_mlc_rev = [re.sub('^.+>[\t]*$', r'', x) for x in ttl_mlc_rev]

ttl_mlc_rev = list(set(ttl_mlc_rev)) # 重複削除
ttl_mlc_rev = sorted(ttl_mlc_rev) # 並べ替え

save_file('md5Metabolite_Label_cid.ttl', "\n".join(ttl_mlc_rev)) # .joinで，改行で'\n'で行を連結




### Function_CategoryOfMebabolite.ttl を作成

ttl_func_categ = ["{0}\t<http://www.w3.org/2000/01/rdf-schema#subClassOf>\t{1} ;\t{2} . \n{1}\t{3} .".format(line1, line2, line3, line4) for line1, line2, line3, line4 in zip(cal3_httpMd5Fuc, cal2_httpMd5Cat, cal3_label_fuc, cal2_label_cat)]
# 検証用 save_file('Function_CategoryOfMebabolite.ttl00.ttl', "\n".join(ttl_func_categ)) # .joinで，改行で'\n'で行を連結

# 文法エラー修正のために，余分な「;」の削除
pattern61=re.compile(r';	 .') 
ttl_func_categ_rev = [re.sub(';	 .', r'.', x) for x in ttl_func_categ]

# 文法エラー修正のために，余分な「;」の削除
pattern2022062501=re.compile(r';     .') 
ttl_func_categ_rev = [re.sub(';     .', r'.', x) for x in ttl_func_categ_rev]


# 主語がないトリプルの削除
ttl_func_categ_rev = [re.sub('^\t.+', r'', x) for x in ttl_func_categ_rev]
# 述語と目的語がないトリプルの削除
pattern2701=re.compile(r'^.+>\t+ \.') 
ttl_func_categ_rev = [re.sub('<.+>[\t\s]\s+\.', r'', x) for x in ttl_func_categ_rev]

ttl_func_categ_rev = [re.sub('\n', r'', x) for x in ttl_func_categ_rev] #空白行の削除

ttl_func_categ_rev = list(set(ttl_func_categ_rev)) # 重複削除
ttl_func_categ_rev = sorted(ttl_func_categ_rev) # 並べ替え

save_file('md5Function_md5CategoryOfMebabolite.ttl', "\n".join(ttl_func_categ_rev)) # .joinで，改行で'\n'で行を連結






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
