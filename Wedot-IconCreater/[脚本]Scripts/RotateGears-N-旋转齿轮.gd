			##                ##########################
######## ## ## #####    ##### # [卓] 多级齿轮控制脚本
## ## ## ## ## ## ##    ## ## # 2024-1014
## ## ## ## ## ## ## ## ## ## # milo-o.fun@qq.com
## ## ## ## ## #####    ##### ##########################

##
@tool extends Control

## 当齿轮更新时 需要手动更新数据
@export_group("旋转功能")
@export var 已旋转 = false
var 旋停状态 = false

@export var 线速度 :float
@export var 齿轮集 :Array[Mis·齿形类]
var 齿轮原转量 :Array[float]
@export_group("改色功能")
@export var 去改色 = false
@export var 统一面色:Color

func _process(delta):
	
	## 刚旋转 初始
	if (已旋转)&&(!旋停状态):
		齿轮原转量.resize(齿轮集.size())
		for i in 齿轮集.size():
			齿轮原转量[i] = 齿轮集[i].rotation
			旋停状态 = true
		
	## 每帧执行
	if 已旋转:
		var 半径O = 齿轮集[0].分度半径()
		var 转量O = 线速度*delta/半径O
		齿轮集[0].rotate(转量O)
		for i in 齿轮集.size()-1:
			var 传递系数 = float(齿轮集[i].齿数)/float(齿轮集[i+1].齿数)
			var 转量I = -转量O*传递系数
			齿轮集[i+1].rotate(转量I)
			转量O = 转量I
		
	## 刚停用 复位
	if (!已旋转)&&(旋停状态):
		for i in 齿轮集.size():
			齿轮集[i].rotation = 齿轮原转量[i]
			旋停状态 = false
	
	if 去改色: 去改色 = Mic·通用库.完成(统一换色)

## 附加改色功能
func 统一换色():
	for i in 齿轮集.size():
		齿轮集[i].面色 = 统一面色
		齿轮集[i].绘制齿形()
