package objects;

import nape.phys.Material;
import flixel.addons.nape.FlxNapeSprite;
import flixel.addons.nape.FlxNapeSpace;
import flixel.addons.nape.FlxNapeSprite;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup;
import flixel.math.FlxPoint;
import flixel.text.FlxText;
import flixel.addons.nape.FlxNapeSpace;
import flixel.addons.nape.FlxNapeSprite;
import nape.callbacks.CbType;
import nape.callbacks.InteractionType;
import nape.callbacks.PreCallback;
import nape.callbacks.PreFlag;
import nape.callbacks.PreListener;
import nape.constraint.PivotJoint;
import nape.geom.Vec2;

//author Daniel Hummus
//pasted from the FlxNape demo
class BoyfriendRagdoll extends FlxTypedGroup<FlxNapeSprite>
{
	public var sprites:Array<FlxNapeSprite>;

	
	public var arm:FlxNapeSprite;
	public var torso:FlxNapeSprite;
	public var head:FlxNapeSprite; 

	public var scale:Float;
	public var joints:Array<PivotJoint>;

	public var armSize:FlxPoint;
	public var headSize:FlxPoint;
	public var torsoSize:FlxPoint;
	
	public var neckHeight:Float;
	public var headRadius:Float;

	public var limbOffset:Float;
	public var torsoOffset:Float;

	var startX:Float;
	var startY:Float;

	/**
	 * Creates the ragdoll
	 * @param	scale	The ragdol size scale factor.
	 */
	public function new(X:Float, Y:Float, Scale:Float = 1)
	{
		super();

		Scale > 0 ? scale = Scale : scale = 1;

		armSize = FlxPoint.get(181 * scale, 239 * scale);
		headSize = FlxPoint.get(318 * scale, 337 * scale);
		torsoSize = FlxPoint.get(402 * scale, 305 * scale);
		
		neckHeight = 20 * scale;
		headRadius = 60 * scale;

		limbOffset = 3 * scale;
		torsoOffset = 5 * scale;

		startX = X;
		startY = Y;

		init();
	}

	public function init()
	{
		sprites = new Array<FlxNapeSprite>();
		arm = new FlxNapeSprite(startX, startY + 198);
		sprites.push(arm);

		torso = new FlxNapeSprite(startX + 101, startY + 163);
		sprites.push(torso);

		head = new FlxNapeSprite(startX + 90, startY);
		sprites.push(head);
		trace(head.body.mass);
		head.body.mass = 1000;
		head.body.setShapeMaterials(Material.wood());
		torso.body.setShapeMaterials(Material.wood());
		arm.body.setShapeMaterials(Material.wood());
		torso.body.mass = 1600;
		arm.body.mass = 600;
		

		add(torso);
		add(arm);
		add(head);

		createGraphics();
		createBodies();
		createContactListeners();
		createJoints();
	}

	function setPos(x:Float, y:Float)
	{
		for (s in sprites)
		{
			s.body.position.x = x;
			s.body.position.y = y;
		}
	}

	function createBodies()
	{
		arm.createRectangularBody(armSize.x, armSize.y);
		torso.createRectangularBody(torsoSize.x, torsoSize.y);

		head.createCircularBody(headRadius);
	}

	function createContactListeners()
	{
		

		var group1:CbType = new CbType();
		var group2:CbType = new CbType();
		var group3:CbType = new CbType();
		

		arm.body.cbTypes.add(group1);
		torso.body.cbTypes.add(group2);
		head.body.cbTypes.add(group3);
		

		var listener;
		//arm ignores body
		listener = new PreListener(InteractionType.COLLISION, group1, group2, ignoreCollision, 0, true);
		listener.space = FlxNapeSpace.space;
	}

	function ignoreCollision(cb:PreCallback):PreFlag
	{
		return PreFlag.IGNORE;
	}

	
	public function createGraphics()
	{
		
		var path = "characters/bfParts/";

		head.loadGraphic(Paths.image('${path}head'));
		torso.loadGraphic(Paths.image('${path}body'));
		arm.loadGraphic(Paths.image('${path}arm'));

		
	}

	function createJoints()
	{
		var constrain:PivotJoint;

		// // lower legs with upper legs.
		// constrain = new PivotJoint(lLLeg.body, lULeg.body, new Vec2(0, -llegSize.y / 2 + 3), new Vec2(0, ulegSize.y / 2 - 3));
		// constrain.space = FlxNapeSpace.space;
		// constrain = new PivotJoint(rLLeg.body, rULeg.body, new Vec2(0, -llegSize.y / 2 + 3), new Vec2(0, ulegSize.y / 2 - 3));
		// constrain.space = FlxNapeSpace.space;

		// // Lower Arms with upper arms.
		// constrain = new PivotJoint(lLArm.body, lUArm.body, new Vec2(0, -larmSize.y / 2 + 3), new Vec2(0, uarmSize.y / 2 - 3));
		// constrain.space = FlxNapeSpace.space;
		// constrain = new PivotJoint(rLArm.body, rUArm.body, new Vec2(0, -larmSize.y / 2 + 3), new Vec2(0, uarmSize.y / 2 - 3));
		// constrain.space = FlxNapeSpace.space;

		// Upper legs with lower torso.
		// constrain = new PivotJoint(lULeg.body, lTorso.body, new Vec2(0, -ulegSize.y / 2 + 3),
		// 	new Vec2(-lTorsoSize.x / 2 + ulegSize.x / 2, lTorsoSize.y / 2 - 6));
		// constrain.space = FlxNapeSpace.space;
		// constrain = new PivotJoint(rULeg.body, lTorso.body, new Vec2(0, -ulegSize.y / 2 + 3),
		// 	new Vec2(lTorsoSize.x / 2 - ulegSize.x / 2, lTorsoSize.y / 2 - 6));
		// constrain.space = FlxNapeSpace.space;

		// // Upper torso with mid lower.
		// constrain = new PivotJoint(uTorso.body, lTorso.body, new Vec2(0, uTorsoSize.y / 2 + torsoOffset), new Vec2(0, -lTorsoSize.y / 2 - torsoOffset));
		// constrain.space = FlxNapeSpace.space;

		// Upper arms with Upper torso.
		constrain = new PivotJoint(arm.body, torso.body, new Vec2(armSize.x, armSize.y / 2),
			new Vec2(50,40));
		constrain.space = FlxNapeSpace.space;

		// Neck with upper torso.
		constrain = new PivotJoint(torso.body, head.body, new Vec2(0, -torsoSize.y / 2 - neckHeight), new Vec2(0, headRadius));
		constrain.space = FlxNapeSpace.space;
	}
}