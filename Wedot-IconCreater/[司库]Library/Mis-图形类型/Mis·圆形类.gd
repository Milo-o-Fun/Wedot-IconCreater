			##                ##########################
######## ## ## #####    ##### # [東] 图形类型-圆形类
## ## ## ## ## ## ##    ## ## # 2024-1014
## ## ## ## ## ## ## ## ## ## # milo-o.fun@qq.com
## ## ## ## ## #####    ##### ##########################

## 图形类型-圆形类
@tool class_name Mis·圆形类 extends Node2D

@export var 去更新 = false

@export var 边数 :int
@export var 半径 :float

@export var 面色 :Color
@export var 线色 :Color
@export var 线宽 :float


var 圆形面 :Polygon2D
var 圆形边 :Line2D

func _ready():
	去更新 = true
	圆形面 = Polygon2D.new()
	圆形边 = Line2D.new()
	
	add_child(圆形面)
	add_child(圆形边)
	
func _process(delta):
	if 去更新: 去更新 = Mic·通用库.完成(绘制圆形)

func 绘制圆形():
	## 合理性判定
	if 边数 <= 3: 边数 = 3 
	## 计算顶点集
	var 点集 :PackedVector2Array =[]
	点集.resize(边数+1)
	var Ri = 2*PI/边数 #每次旋转角
	var Rv = Vector2(0,-半径) #半径向量化
	for i in 边数: 
		点集[i] = Rv.rotated(i*Ri)
	点集[-1] = 点集[0] #首尾相衔
	## 绘制圆形面
	圆形面.polygon = 点集
	圆形面.color = 面色
	## 绘制圆形边
	圆形边.points = 点集
	圆形边.default_color = 线色
	圆形边.width = 线宽
