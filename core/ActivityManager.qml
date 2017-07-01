Item {
	constructor: {
		this._activityStack = []
	}

	push(name, intent, state): {
		this._activityStack.push({ "name": name, "intent": intent, "state": state })
		this.initTopIntent()
	}

	pop: {
		this._activityStack.pop()
		this.initTopIntent()
	}

	setState(state, idx): {
		this._activityStack[idx || this._activityStack.length - 1].state = state
	}

	initTopIntent: {
		if (!this._activityStack.length) {
			log("Activity stack is empty")
			return
		}

		var topActivity = this._activityStack[this._activityStack.length - 1]
		var children = this.children

		for (var i = 0; i < children.length; ++i) {
			var child = children[i]
			if (!child || !(child instanceof _globals.controls.core.Activity))
				continue

			child.visible = false
			if (child.name === topActivity.name) {
				log("Init:", topActivity)
				child.init(topActivity.intent, topActivity.state)
				child.index = this._activityStack.length - 1
				child.visible = true
				child.setFocus()
			}
		}
	}
}