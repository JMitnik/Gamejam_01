extends Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var image = Image.create(64, 64, false, Image.FORMAT_RGB8)
	image.fill(Color.ORANGE)
	
	var texture = ImageTexture.create_from_image(image)
	self.texture = texture


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
