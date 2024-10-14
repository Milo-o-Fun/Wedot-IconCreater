			##                ##########################
######## ## ## #####    ##### # [卓] 导出图标控制脚本
## ## ## ## ## ## ##    ## ## # 2024-1014
## ## ## ## ## ## ## ## ## ## # milo-o.fun@qq.com
## ## ## ## ## #####    ##### ##########################

##
@tool extends Control

## 当齿轮更新时 需要手动更新数据
@export var 去导出 = false

@export_dir var 指定路径 :String
@export var 文件名称 :String

@export var 视图 :Viewport

func _process(delta):
	if 去导出:
		去导出 = false
		
		var 文件夹 = DirAccess.open(指定路径)
		var 文件名 = 文件名称+".png"
		if 文件夹.file_exists(文件名):
			print("ExportIcon-导出图标: 已存在该文件名称")
			return
		else:
			var 图片 = 视图.get_texture().get_image()
			var e = 图片.save_png(指定路径+"/"+文件名)
			if e: 
				print("ExportIcon-导出图标: 导出失败,请重新尝试")
		
