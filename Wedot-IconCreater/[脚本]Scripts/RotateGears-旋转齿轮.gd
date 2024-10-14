			##                ##########################
######## ## ## #####    ##### # [卓] 旋转齿轮控制脚本
## ## ## ## ## ## ##    ## ## # 2024-1014
## ## ## ## ## ## ## ## ## ## # milo-o.fun@qq.com
## ## ## ## ## #####    ##### ##########################

##
@tool extends Control

## 当齿轮更新时 需要手动更新数据
@export var 已启用 = false
var 启停状态 = false

@export var 线速度 :float
@export var 齿轮A :Mis·齿形类
@export var 齿轮B :Mis·齿形类

var 齿轮A_原转量 :float
var 齿轮B_原转量 :float

func _process(delta):
	## 刚启用 初始
	if (已启用)&&(!启停状态):
		齿轮A_原转量 = 齿轮A.rotation
		齿轮B_原转量 = 齿轮B.rotation
		启停状态 = true
	
	## 每帧执行
	if 已启用:
		var 半径A = 齿轮A.分度半径()
		
		var 传递系数 = float(齿轮A.齿数)/float(齿轮B.齿数)
		var 转量A = 线速度*delta/半径A
		var 转量B = 转量A*传递系数
		
		齿轮A.rotate(转量A)
		齿轮B.rotate(-转量B)
		
	## 刚停用 复位
	if (!已启用)&&(启停状态):
		齿轮A.rotation = 齿轮A_原转量
		齿轮B.rotation = 齿轮B_原转量
		启停状态 = false
