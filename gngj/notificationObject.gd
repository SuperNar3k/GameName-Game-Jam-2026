extends Node
class_name Notification

var notificationType : String
var itemType : String
var item 

func createNotification(_notificationType : String, _itemType : String, _item : Variant): 
	notificationType = _notificationType
	itemType = _itemType
	item = _item
	
