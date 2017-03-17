
function Start()
	input.mouseVisible = true;

	setTitle();

	setBack();

	setBtn();

	CreateConsoleAndDebugHud();

	SubscribeToEvent("KeyUp", "HandleKeyUp");
end

function setTitle()
	local helloText = Text:new();
	helloText.text = "sudoku";
	helloText:SetFont(cache:GetResource("Font", "Fonts/yahei.ttf"), 20);
	helloText.color = Color(255, 255, 0);
	helloText.horizontalAlignment = HA_CENTER;
	helloText.verticalAlignment = VA_TOP;
	ui.root:AddChild(helloText);
end

function setBack()
	local backTexture = cache:GetResource("Texture2D", "res/sudoku/back.jpg");
	if backTexture == nil then
		return;
	end

	backSprite = ui.root:CreateChild("Sprite", "back");
	backSprite:SetTexture(backTexture);

	local backWidth = backTexture.width;
	local backHeight = backTexture.height;

	backSprite:SetSize(backWidth, backHeight);
	backSprite:SetHotSpot(IntVector2(backWidth / 2, backHeight / 2));
	backSprite:SetAlignment(HA_CENTER, VA_CENTER);
	backSprite.priority = -300;
	log:Write(LOG_INFO, "size: " .. backWidth .. ", " .. backHeight);
end

function setBtn()
	local element = ui.root:GetChild("back", true);
	local backSprite = tolua.cast(element, "Sprite");
	pos = backSprite:GetScreenPosition();
	log:Write(LOG_INFO, "pos: " .. pos.x .. ", " .. pos.y);

	btnArray = {};
	for i = 1, 9 do
		btnArray[i] = {};
		for j = 1, 9 do
			btn = ui.root:CreateChild("Button", "btn_" .. i .. "_" .. j)
			btn.texture = cache:GetResource("Texture2D", "res/sudoku/" .. j .. ".tga");

			btnWidth = btn.texture.width;
			btnHeight = btn.texture.height;
			btn:SetSize(btnWidth, btnHeight);
			btn:SetPosition(pos.x + (j - 1) * (btnWidth + 3) + 75, pos.y + (i - 1) * (btnHeight + 7) + 8);
			btnArray[i][j] = btn;
		end
	end
end

function CreateConsoleAndDebugHud()
	local uiStyle = cache:GetResource("XMLFile", "UI/DefaultStyle.Xml");
	if uiStyle == nil then
		return;
	end

	engine:CreateConsole();
	console.defaultStyle = uiStyle;
	console.background.opacity = 0.8;

	engine:CreateDebugHud();
	debugHud.defaultStyle = uiStyle;
end

function HandleKeyUp(eventType, eventData)
	local key = eventData["key"]:GetInt();
	if key == KEY_ESCAPE then
        if console:IsVisible() then
			console:SetVisible(false);
		else
			engine:Exit();
		end
	end
end
