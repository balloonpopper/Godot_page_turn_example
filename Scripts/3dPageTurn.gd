extends Spatial

var CurrentPage=1		# usually whats on the front page of page A except for when turning the back cover
var TotalNumberOfPages=8
var PageTexture
# PageSpriteList[]
export(float) var PageSpeedRatio = 1

## Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimationPlayer.set_speed_scale(PageSpeedRatio)
	$AnimationPlayer.play("Idle")
	LoadPageGraphicsAllPages()
	CurrentPage-=2		# We used CurrentPage=1 to load all the pages correctly, now reset for the CurrentPage logic as we haven't opened the book yet


func _unhandled_input(event):
	if event is InputEventKey:
		if event.pressed :
			print("CP="+str(CurrentPage))
			if event.scancode == KEY_ESCAPE:
				get_tree().quit()
			elif event.scancode == KEY_RIGHT:
				if $AnimationPlayer.is_playing() == false:		# Current page turning has to complete before you can turn more pages
					TurnPageNext()
			elif event.scancode == KEY_LEFT:
				print_debug("left+"+str(CurrentPage))
				if $AnimationPlayer.is_playing() == false:		# Current page turning has to complete before you can turn more pages
					TurnPagePrevious()
				
func TurnPageNext():
	if CurrentPage==-1:							# Yet to open the book, open for first time
		$AnimationPlayer.play("TurnPageA")
		CurrentPage+=2
	elif CurrentPage < TotalNumberOfPages-3:	# Turn page in the middle
		LoadPageGraphicsAllPages()
		$AnimationPlayer.play("TurnPageB")
		CurrentPage+=2
	elif CurrentPage == TotalNumberOfPages-3:	# Closing book to back cover
		$AnimationPlayer.play("TurnPageC")
		CurrentPage+=2				
	# else we're already looking at the back cover, no turning forward allowed

func TurnPagePrevious():
	if CurrentPage==1:							# Turning to the front cover
		print("PA")
		$AnimationPlayer.play_backwards("TurnPageA")
		CurrentPage-=2
	elif CurrentPage == TotalNumberOfPages-1:		# Reopening book from back cover
		print("PC")
		$AnimationPlayer.play_backwards("TurnPageC")
		CurrentPage-=2				
	elif CurrentPage > 1:	# Turning a page in the middle
		print("PB")
		CurrentPage-=2			
		LoadPageGraphicsAllPages()
		$AnimationPlayer.play_backwards("TurnPageB")
	# else we're already looking at the front cover, no turning backward allowed 
	

func ChangePageImage(Page,TextureFile):
	var material = SpatialMaterial.new()
	
	PageTexture=load(TextureFile)
	material.set_texture(0,PageTexture)
	get_node(Page).set_material_override(material)
	
func LoadPageGraphicsAllPages():
	ChangePageImage("PageA/FrontPage","res://2DImages/3DPageTurnTest/page"+str(CurrentPage)+".png")
	ChangePageImage("PageA/BackPage","res://2DImages/3DPageTurnTest/page"+str(CurrentPage+1)+".png")
	ChangePageImage("PageB/FrontPage","res://2DImages/3DPageTurnTest/page"+str(CurrentPage+2)+".png")
	ChangePageImage("PageB/BackPage","res://2DImages/3DPageTurnTest/page"+str(CurrentPage+3)+".png")
	ChangePageImage("PageC/FrontPage","res://2DImages/3DPageTurnTest/page"+str(CurrentPage+4)+".png")
	ChangePageImage("PageC/BackPage","res://2DImages/3DPageTurnTest/page"+str(CurrentPage+5)+".png")
	
func LoadPageGraphicsBackCover():
	ChangePageImage("PageB/FrontPage","res://2DImages/3DPageTurnTest/page"+str(CurrentPage)+".png")
	ChangePageImage("PageB/BackPage","res://2DImages/3DPageTurnTest/page"+str(CurrentPage+1)+".png")
	ChangePageImage("PageC/FrontPage","res://2DImages/3DPageTurnTest/page"+str(CurrentPage+2)+".png")
	ChangePageImage("PageC/BackPage","res://2DImages/3DPageTurnTest/page"+str(CurrentPage+3)+".png")
	
