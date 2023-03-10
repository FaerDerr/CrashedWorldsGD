extends TextureRect

signal onPressed
signal onMouseHover
signal onMouseLeft
signal equipedItem

@export var isEquipSlot : bool = false

var itemHolding = null :
	set(value):
		itemHolding = value
		_on_item_changed(value)
		
	get : return itemHolding

func _process(delta):
	if itemHolding != null:
		%Quantity.text = str(itemHolding.amount)
	else:
		%Quantity.text = ""
		

func _on_item_changed(item):
	$InvSlot.show()
	$Quantity.show()
	if item != null:
		update_icons(item.icon)
		%Quantity.text = str(item.amount)
		%InvSlot.tooltip_text = item.description
		self_modulate = Color.GRAY
	else:
		update_icons(null)
		%Quantity.text = ""
		%InvSlot.tooltip_text = ""
		self_modulate = Color.WHITE
	
	if isEquipSlot:
		equipedItem.emit(item)

func update_icons(tex):
	%InvSlot.texture_normal = tex
	%InvSlot.texture_pressed = tex
	%InvSlot.texture_hover = tex
	%InvSlot.texture_disabled = tex
	%InvSlot.texture_focused = tex
	

func _on_inv_slot_pressed():
	onPressed.emit(self)

func _on_mouse_exited():
	onMouseLeft.emit(self)

func _on_inv_slot_gui_input(_event):
	onMouseHover.emit(self)
