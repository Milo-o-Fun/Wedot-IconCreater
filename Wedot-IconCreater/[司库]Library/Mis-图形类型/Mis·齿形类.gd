			##                ##########################
######## ## ## #####    ##### # [東] 图形类型-齿形形类
## ## ## ## ## ## ##    ## ## # 2024-1014
## ## ## ## ## ## ## ## ## ## # milo-o.fun@qq.com
## ## ## ## ## #####    ##### ##########################

## 图形类型-齿形类(齿轮)
@tool class_name Mis·齿形类 extends Node2D

@export var 去更新 = false

@export var 齿数 :int
@export_range(-0.1,0.2) var 偏度 :float

@export var 顶齿半径 :float
@export var 根齿半径 :float
@export var 弧细分 :int

@export var 线色 :Color
@export var 线宽 :float
@export var 面色 :Color

var 齿形面 :Polygon2D
var 齿形边 :Line2D

func _ready():
	去更新 = true
	齿形面 = Polygon2D.new()
	齿形边 = Line2D.new()
	add_child(齿形面)
	add_child(齿形边)
	
func _process(delta):
	if 去更新: 去更新 = Mic·通用库.完成(绘制齿形)
	
func 绘制齿形():
	## 合理性判定
	if 齿数 < 3: 齿数 = 3
	if 弧细分 <  0: 弧细分 = 0
	## 计算顶点集
	var 点集 :PackedVector2Array =[]
	点集.resize(4*齿数+1)
	var Ri = 2*PI/齿数 #每次旋转角
	var RvI = Vector2(0,-根齿半径) #半径向量化
	var RvO = Vector2(0,-顶齿半径) #半径向量化
	for i in 齿数:
		var ic = 4*i
		点集[ic+0] = RvI.rotated((i-0.25)*Ri-偏度)
		点集[ic+1] = RvO.rotated((i-0.25)*Ri+偏度)
		点集[ic+2] = RvO.rotated((i+0.25)*Ri-偏度)
		点集[ic+3] = RvI.rotated((i+0.25)*Ri+偏度)
	点集[-1] = 点集[0] #首尾相衔
	## 绘制齿形面
	齿形面.polygon = 点集
	齿形面.color = 面色
	## 绘制齿形边
	齿形边.points = 点集
	齿形边.default_color = 线色
	齿形边.width = 线宽

func 分度半径():
	return (顶齿半径+根齿半径)/2
