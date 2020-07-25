extends Node2D

var CurrentPage=1		# Page currently showing on the left hand side of the screen
var TotalNumberOfPages=8
var PageTexture
# PageSpriteList[]
export(float) var PageSpeedRatio = 1

func _unhandled_input(event):
	if event is InputEventKey:
		if event.pressed :
			if event.scancode == KEY_ESCAPE:
				get_tree().quit()
			elif event.scancode == KEY_RIGHT:
				if $AnimationPlayer.is_playing() == false:
					if CurrentPage < TotalNumberOfPages-2:
						PageTurnNextPartA()
			elif event.scancode == KEY_LEFT:
				if $AnimationPlayer.is_playing() == false:
					if CurrentPage > 1:
						CurrentPage-=2
						PageTurnPreviousPartA()
				
	
	
## Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Ensure any changes made in the GUI are overwritten by resetting back to the starting page state
	$AnimationPlayer.play("Idle")
	$AnimationPlayer.set_speed_scale(PageSpeedRatio)
	$AnimationPlayer.connect("animation_finished", self, "PlayNextAnimation")

func LoadPageGraphics():
	print_debug("Loading page="+str(CurrentPage))
	PageTexture=load("res://2DImages/PageTurnTest/page"+str(CurrentPage)+".png")
	$Page1.set_texture(PageTexture)
	PageTexture=load("res://2DImages/PageTurnTest/page"+str(CurrentPage+1)+".png")
	$Page2.set_texture(PageTexture)
	PageTexture=load("res://2DImages/PageTurnTest/page"+str(CurrentPage+2)+".png")
	$Page3.set_texture(PageTexture)
	PageTexture=load("res://2DImages/PageTurnTest/page"+str(CurrentPage+3)+".png")
	$Page4.set_texture(PageTexture)

func PageTurnNextPartA():
	LoadPageGraphics()
	$AnimationPlayer.play("TurnPageNextA")

func PageTurnNextPartB():
	$AnimationPlayer.play("TurnPageNextB")

func PageTurnPreviousPartA():
	LoadPageGraphics()
	$AnimationPlayer.play("TurnPagePreviousA")

func PageTurnPreviousPartB():
	$AnimationPlayer.play("TurnPagePreviousB")


func PlayNextAnimation(AnimationJustCompleted):
	if (AnimationJustCompleted == "TurnPageNextA"):
			PageTurnNextPartB()
	if (AnimationJustCompleted == "TurnPageNextB"):
			CurrentPage+=2
	if (AnimationJustCompleted == "TurnPagePreviousA"):
			PageTurnPreviousPartB()
#	if (AnimationJustCompleted == "TurnPagePreviousB"):
#			
