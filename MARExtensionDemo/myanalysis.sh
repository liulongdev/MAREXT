export LANG="zh_CN.UTF-8"
export LC_COLLATE="zh_CN.UTF-8"
export LC_CTYPE="zh_CN.UTF-8"
export LC_MESSAGES="zh_CN.UTF-8"
export LC_MONETARY="zh_CN.UTF-8"
export LC_NUMERIC="zh_CN.UTF-8"
export LC_TIME="zh_CN.UTF-8"
export LC_ALL=

function checkDepend () {
	command -v xcpretty >/dev/null 2>&1 || { 
		echo >&2 "I require xcpretty but it's not installed.  Install：gem install xcpretty"; 
		exit
		}
	command -v oclint-json-compilation-database >/dev/null 2>&1 || { 
		echo >&2 "I require oclint-json-compilation-database but it's not installed.  Install：brew install oclint"; 
		exit
		}
}

function oclintForProject () {

	# 检测依赖
	checkDepend

	projectName=$1
	scheme=$2
    reportType=$3

    REPORT_PMD="pmd"
    REPORT_XCODE="xcode"
	REPORT_HTML="html"
	
	myworkspace=${projectName}
	myscheme=${scheme} 
	echo "myworkspace是：${myworkspace}"
	echo "myscheme是：${myscheme}"
	echo "reportType为：${reportType}"

	# 清除上次编译数据
	if [ -d ./build/derivedData ]; then
		echo '-----清除上次编译数据derivedData-----'
		rm -rf ./build/derivedData
	fi

	echo '-----删除文件-----'	
	rm pmd.html
	rm xcodebuild.log
	rm compile_commands.json
	rm oclint_result.html


	echo '-----clean-----'
	if [[ ${isworkspace} == 'true' ]]; then
		xcodebuild -workspace $myworkspace -scheme $myscheme -sdk iphonesimulator clean
	else
		xcodebuild -target $myscheme  -sdk iphonesimulator clean
	fi	
 	# xcodebuild -workspace $myworkspace -scheme $myscheme -configuration Debug  -sdk iphonesimulator clean
	#xcodebuild clean

	echo '-----开始编译-----'

	# 生成编译数据

	if [[ ${isworkspace} == 'true' ]]; then
		xcodebuild CLANG_ENABLE_MODULE_DEBUGGING=NO -workspace ${myworkspace} -scheme ${myscheme} -configuration Debug -sdk iphonesimulator -derivedDataPath ./build/derivedData | tee xcodebuild.log | xcpretty -r json-compilation-database -o compile_commands.json
	else
		# xcodebuild CLANG_ENABLE_MODULE_DEBUGGING=NO -target ${myscheme} -configuration Debug -sdk iphonesimulator -derivedDataPath ./build/derivedData | tee xcodebuild.log | xcpretty -r json-compilation-database -o compile_commands.json
		xcodebuild -target ${myscheme} -sdk iphonesimulator COMPILER_INDEX_STORE_ENABLE=NO build | tee xcodebuild.log | xcpretty -r json-compilation-database --output compile_commands.json
	fi
	

	if [ -f ./compile_commands.json ]
		then
		echo '-----编译数据生成完毕-----'
	else
		echo "-----生成编译数据失败-----"
		return -1
	fi

	echo '-----infer分析中-----'
	if [[ ${isworkspace} == 'true' ]]; then
		infer --keep-going -- xcodebuild -workspace ${myworkspace} -scheme ${myscheme} -configuration Debug -sdk iphonesimulator
	else
		infer --keep-going -- xcodebuild -target ${myscheme} -configuration Debug -sdk iphonesimulator
	fi
	# infer 增量
	# infer --incremental -- xcodebuild -workspace ${myworkspace} -scheme ${myscheme} -configuration Debug -sdk iphonesimulator
	# infer --incremental -- xcodebuild -target ${myscheme} -configuration Debug -sdk iphonesimulator 


	echo '-----infer结束-----'

	echo '-----oclint分析中-----'

	# 自定义排除警告的目录，将目录字符串加到数组里面
	# 转化为：-e Debug.m -e Port.m -e Test
	# exclude_files=("Pods" "DianDuShuUnity4_7")
	exclude_files=("Pods")

	exclude=""
	for i in ${exclude_files[@]}; do
		exclude=${exclude}"-e "${i}" "
	done
	echo "排除目录：${exclude}"

    # 分析reportType
	if [[ ${reportType} =~ ${REPORT_PMD} ]]  
	then
		nowReportType="-report-type pmd -o pmd.xml"
	elif [[ ${reportType} =~ ${REPORT_HTML} ]] 
	then
		nowReportType="-report-type html -o oclint_result.html"	
	else
		nowReportType="-report-type xcode"
	fi

	# 自定义report 如：
	# nowReportType="-report-type html -o oclint_result.html"

	# 生成报表
	oclint-json-compilation-database ${exclude} -- \
	${nowReportType} \
	-rc LONG_LINE=200 \
	-rc LONG_VARIABLE_NAME=30 \
	-disable-rule ShortVariableName \
	-disable-rule ObjCAssignIvarOutsideAccessors \
	-disable-rule AssignIvarOutsideAccessors \
	-max-priority-1=100 \
	-max-priority-2=1000 \
	-max-priority-3=100000

	# --命名
	# 变量名字最长字节
	#-rc=LONG_VARIABLE_NAME=20 \
	# 变量名字最短字节
	#-disable-rule ShortVariableName \
	# --size
	# 圈复杂度
	#-re=CYCLOMATIC_COMPLEXITY=10 \
	# 每个类最行数
	#-rc=LONG_CLASS=700 \
	# 每行字节数量
	#-rc=LONG_LINE=200 \
	# 每个方法行数
	#-rc=LONG_METHOD=80 \
	# 忽略注释后括号后的有效代码行数
	#-rc=NCSS_METHOD=40 \
	# 嵌套深度
	#-rc=NESTED_BLOCK_DEPTH=5 \
	# 字段数量
	#-rc=TOO_MANY_FIELDS=20 \
	# 方法数量
	#-rc=TOO_MANY_METHODS=30 \
	# 方法参数
	#-rc=TOO_MANY_PARAMETERS=6

    #rm compile_commands.json
    if [[ ${reportType} =~ ${REPORT_PMD} ]] && [ ! -f ./pmd.xml ]
    then
        echo "-----oclint分析失败-----"
		return -1
    else
	    echo '-----oclint分析完毕-----'
	    return 0
    fi
}

# 替换workspace的名字  如果不是workspace可不填
myworkspace="MARExtensionDemo.xcodeproj" 
# 替换scheme的名字
myscheme="MARExtensionDemo" 
# 输出方式 xcode/pmd
reportType="html"
# 是否是pod申城的workdspce，如果是则写true
isworkspace='false'

oclintForProject ${myworkspace} ${myscheme} ${reportType}