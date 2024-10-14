			##                ##########################
######## ## ## #####    ##### # [库]MiCom·通用库
## ## ## ## ## ## ##    ## ## # 2024-1014(Wedot)
## ## ## ## ## ## ## ## ## ## # milo-o.fun@qq.com
## ## ## ## ## #####    ##### ##########################

## 
@tool class_name Mic·通用库 extends Object

## 概念 
## <节点> 单一特定子节点 
## <孖> 全部子节点
## <孨> 全部子孙后代节点

## 删除释放 子节点
static func 丢孖(节点:Node):
	for c in 节点.get_children():c.free()
static func 罢孖(节点:Node):
	for c in 节点.get_children():c.queue_free()
# 2024-0808 #

## 删除释放 指定类型子节点
static func 罢孖·类(节点:Node,类型:String):
	if !类型: return
	for c in 节点.get_children():
		if c.get_class()==类型:节点.queue_free()
# 2024-1008 #

## 执行函数并返回一个false
static func 完成(function:Callable) ->bool:
	function.call()
	return false
# 2024-0808 #

## 通过层级索引 获取节点
static func 其孙·索(节点:Node,索引:PackedInt32Array) ->Node:
	for idx in 索引:
		节点 = 节点.get_child(idx)
	return 节点
# 2024-0808 #

## 返回该类型首个子节点点
static func 其子·类(节点:Node,类名:String):
	var 子集 = 节点.get_children()
	for c in 子集:
		if c.get_class()==类名:return c
	return null

## 返回该类型所有子节点点
static func 其孖·类(节点:Node,类名:String):
	var 目标 = []
	var 子集 = 节点.get_children()
	for c in 子集:
		if c.get_class()==类名:
			目标.append(c)
	return 目标
