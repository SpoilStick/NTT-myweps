#define init

global.sprGreyMissile = sprite_add("GreyMissile.png", 1, 18, 7)
global.sprFireMissile = sprite_add("FireMissile.png", 1, 18, 7)

#define create_wizard_shot(_d)

with instance_create(x + _d * 2, y + _d * 2, CustomProjectile) {
	motion_set(other.gunangle, 10)
	sprite_index = global.sprGreyMissile
	image_angle = direction
	team = other.team
	creator = other
	damage = 2 + irandom_range(-1, 1)
	swerve_dir = _d
	old_dir = direction
	image_xscale = 0.5
	image_yscale = 0.5
	on_step = script_ref_create(wizard_shot_step)
}

#define wizard_shot_step

direction += swerve_dir * 10

if (old_dir > -20 + direction) {
	direction *= 1.1
}
if (old_dir < 20 + direction) {
	direction /= 1.1
}

#define bullet_hit
if place_meeting(x,y,hitme){
	with instance_nearest(x,y,hitme) if team != other.team{
		my_health -= other.damage
		sprite_index = spr_hurt
		sound_play(snd_hurt)
	}
}
instance_destroy()

#define bullet_step
if image_index = 1{
	image_speed = 0
}
#define bullet_draw
draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, image_blend, 1.0);
draw_set_blend_mode(bm_add);
draw_sprite_ext(sprite_index, image_index, x, y, 1.75*image_xscale, 1.75*image_yscale, image_angle, image_blend, 0.25);
draw_set_blend_mode(bm_normal);

#define actually_nothing

// _s = Spread in degrees, _o = the offset of the shot in degrees(for things like like triple machinegun), needs to be configured in the weapon script to change between shots, _p = projection in pixels, use the gun length
#define create_bullet_cannon(_s, _o, _p)

with instance_create(x + lengthdir_x(_p, gunangle), y + lengthdir_y(_p, gunangle), CustomProjectile){
	motion_set(other.gunangle + (_o + random_range(_s/-2, _s/2) * other.accuracy), 8)
	sprite_index = sprAllyBullet
	image_xscale = 2
	image_yscale = 2
	typ = 1
	mask_index = mskBullet1
	damage = 20
	team = other.team
	creator = other
	recycle_amount = 10
	image_speed = 1
	image_angle = direction
	on_step = script_ref_create(bullet_step)
	on_destroy = script_ref_create(bullet_cannon_destroy)
	on_hit = script_ref_create(bullet_hit)
	on_draw = script_ref_create(bullet_draw)
}

#define bullet_cannon_destroy
for (var i = random_range(-9,0); i < 360 i += 10) {
	with instance_create(x + lengthdir_x(1, direction), y + lengthdir_y(1, direction), Bullet1) {
		motion_set(i, 11)
		team = other.team;
		creator = other;
		image_angle = direction;
	}
}

#define create_super_bullet_cannon(_s, _o, _p)

with instance_create(x + lengthdir_x(_p, gunangle), y + lengthdir_y(_p, gunangle), CustomProjectile){
	motion_set(other.gunangle + (_o + random_range(_s/-2, _s/2) * other.accuracy), 6)
	sprite_index = sprAllyBullet
	image_xscale = 3
	image_yscale = 3
	typ = 1
	mask_index = mskBullet1
	damage = 50
	team = other.team
	creator = other
	recycle_amount = 20
	image_speed = 1
	image_angle = direction
	on_step = script_ref_create(bullet_step)
	on_destroy = script_ref_create(super_bullet_cannon_destroy)
	on_hit = script_ref_create(bullet_hit)
	on_draw = script_ref_create(bullet_draw)
}

#define super_bullet_cannon_destroy
with (instance_create(x, y, PortalClear)) {
	image_xscale = 1;
	image_yscale = 1;
}
for (var i = random_range(-89,0); i < 360 i += 90) {
	with instance_create(x + lengthdir_x(1, direction), y + lengthdir_y(1, direction), CustomProjectile) {
		motion_set(i, 8)
		sprite_index = sprAllyBullet
		image_xscale = 2
		image_yscale = 2
		typ = 1
		mask_index = mskBullet1
		damage = 20
		team = other.team
		creator = other
		recycle_amount = 10
		image_speed = 1
		image_angle = direction
		on_step = script_ref_create(bullet_step)
		on_destroy = script_ref_create(bullet_cannon_destroy)
		on_hit = script_ref_create(bullet_hit)
		on_draw = script_ref_create(bullet_draw)
	}
}

#define create_ultra_bullet_cannon(_s, _o, _p)

with instance_create(x + lengthdir_x(_p, gunangle), y + lengthdir_y(_p, gunangle), CustomProjectile){
	motion_set(other.gunangle + (_o + random_range(_s/-2, _s/2) * other.accuracy), 4)
	sprite_index = sprAllyBullet
	image_xscale = 4
	image_yscale = 4
	typ = 1
	mask_index = mskBullet1
	damage = 80
	team = other.team
	creator = other
	recycle_amount = 20
	image_speed = 1
	image_angle = direction
	on_step = script_ref_create(bullet_step)
	on_destroy = script_ref_create(ultra_bullet_cannon_destroy)
	on_hit = script_ref_create(bullet_hit)
	on_draw = script_ref_create(bullet_draw)
}

#define ultra_bullet_cannon_destroy
with (instance_create(x, y, PortalClear)) {
	image_xscale = 1.33;
	image_yscale = 1.33;
}
for (var i = random_range(-89,0); i < 360 i += 90) {
	with instance_create(x + lengthdir_x(1, direction), y + lengthdir_y(1, direction), CustomProjectile) {
		motion_set(i, 6)
		sprite_index = sprAllyBullet
		image_xscale = 4
		image_yscale = 4
		typ = 1
		mask_index = mskBullet1
		damage = 50
		team = other.team
		creator = other
		recycle_amount = 20
		image_speed = 1
		image_angle = direction
		on_step = script_ref_create(bullet_step)
		on_destroy = script_ref_create(super_bullet_cannon_destroy)
		on_hit = script_ref_create(bullet_hit)
		on_draw = script_ref_create(bullet_draw)
	}
}

#define create_super_ultra_bullet_cannon(_s, _o, _p)

with instance_create(x + lengthdir_x(_p, gunangle), y + lengthdir_y(_p, gunangle), CustomProjectile){
	motion_set(other.gunangle + (_o + random_range(_s/-2, _s/2) * other.accuracy), 2)
	sprite_index = sprAllyBullet
	image_xscale = 6
	image_yscale = 6
	typ = 1
	mask_index = mskBullet1
	damage = 110
	team = other.team
	creator = other
	recycle_amount = 20
	image_speed = 1
	image_angle = direction
	on_step = script_ref_create(bullet_step)
	on_destroy = script_ref_create(super_ultra_bullet_cannon_destroy)
	on_hit = script_ref_create(bullet_hit)
	on_draw = script_ref_create(bullet_draw)
}

#define super_ultra_bullet_cannon_destroy
with (instance_create(x, y, PortalClear)) {
	image_xscale = 2;
	image_yscale = 2;
}
for (var i = random_range(-89,0); i < 360 i += 90) {
	with instance_create(x + lengthdir_x(1, direction), y + lengthdir_y(1, direction), CustomProjectile) {
		motion_set(i, 4)
		sprite_index = sprAllyBullet
		image_xscale = 7
		image_yscale = 7
		typ = 1
		mask_index = mskBullet1
		damage = 80
		team = other.team
		creator = other
		recycle_amount = 20
		image_speed = 1
		image_angle = direction
		on_step = script_ref_create(bullet_step)
		on_destroy = script_ref_create(ultra_bullet_cannon_destroy)
		on_hit = script_ref_create(bullet_hit)
		on_draw = script_ref_create(bullet_draw)
	}
}

#define create_extreme_super_ultra_bullet_cannon(_s, _o, _p)

with instance_create(x + lengthdir_x(_p, gunangle), y + lengthdir_y(_p, gunangle), CustomProjectile) {
	motion_set(other.gunangle + (_o + random_range(_s/-2, _s/2) * other.accuracy), 1.5)
	sprite_index = sprAllyBullet
	image_xscale = 9
	image_yscale = 9
	typ = 1
	mask_index = mskBullet1
	damage = 150
	team = other.team
	creator = other
	recycle_amount = 20
	image_speed = 1
	image_angle = direction
	on_step = script_ref_create(bullet_step)
	on_destroy = script_ref_create(extreme_super_ultra_bullet_cannon_destroy)
	on_hit = script_ref_create(bullet_hit)
	on_draw = script_ref_create(bullet_draw)
}

#define extreme_super_ultra_bullet_cannon_destroy
with (instance_create(x, y, PortalClear)) {
	image_xscale = 3;
	image_yscale = 3;
}
for (var i = random_range(-89,0); i < 360 i += 90) {
	with instance_create(x + lengthdir_x(1, direction), y + lengthdir_y(1, direction), CustomProjectile) {
		motion_set(i, 2)
		sprite_index = sprAllyBullet
		image_xscale = 6
		image_yscale = 6
		typ = 1
		mask_index = mskBullet1
		damage = 110
		team = other.team
		creator = other
		recycle_amount = 20
		image_speed = 1
		image_angle = direction
		on_step = script_ref_create(bullet_step)
		on_destroy = script_ref_create(super_ultra_bullet_cannon_destroy)
		on_hit = script_ref_create(bullet_hit)
		on_draw = script_ref_create(bullet_draw)
	}
}

#define create_bullet_turret

with instance_create(x,y,CustomProjectile) {
	motion_set(other.gunangle, 10 + random(2))
	team = other.team
	creator = other
	sprite_index = sprAllyBullet
	image_speed = 0
	timer = 150
	timer2 = 0
	on_hit = script_ref_create(actually_nothing)
	on_wall = script_ref_create(actually_nothing)
	on_step = script_ref_create(bullet_turret_step)
	on_draw = script_ref_create(bullet_turret_draw)
}

#define bullet_turret_step
scale = random_range(0.9,1.1)
image_xscale = 2*scale
image_yscale = 2*scale

if place_meeting(x + hspeed,y,Wall){
	hspeed *= -1
}
if place_meeting(x,y +vspeed,Wall){
	vspeed *= -1
}
if (speed >= 1) {
	speed /= 1.1
}
else {
speed = 0;
}
if (speed = 0) {
	if(timer2 > 1) {
		if instance_exists(enemy) gunangle = point_direction(x,y,instance_nearest(x,y,enemy).x,instance_nearest(x,y,enemy).y)
		else gunangle = random(359)
		with instance_create(x,y,Bullet1) {
			motion_set(other.gunangle, 11)
			team = other.team
			image_angle = direction
		}
		timer2 -= 5;
	}
	else {
	timer2 += 1;
	}
	timer -= 1
	if (timer <= 0) {
	instance_destroy();
	}
}

#define bullet_turret_draw
draw_sprite_ext(sprite_index, image_index, x, y, .4*image_xscale, .4*image_yscale, image_angle, image_blend, 1.0);
draw_set_blend_mode(bm_add);
draw_sprite_ext(sprite_index, image_index, x, y, 0.625*image_xscale, 0.6245*image_yscale, image_angle, image_blend, 0.1);
draw_set_blend_mode(bm_normal);

#define create_random_bullet_turret

with instance_create(x,y,CustomProjectile) {
	motion_set(other.gunangle, 10 + random(2))
	team = other.team
	creator = other
	sprite_index = sprAllyBullet
	image_speed = 0
	timer = 160
	timer2 = 0
	on_hit = script_ref_create(actually_nothing)
	on_wall = script_ref_create(actually_nothing)
	on_step = script_ref_create(random_bullet_turret_step)
	on_draw = script_ref_create(random_bullet_turret_draw)
}

#define random_bullet_turret_step
scale = random_range(0.9,1.1)
image_xscale = 2*scale
image_yscale = 2*scale

if place_meeting(x + hspeed,y,Wall){
	hspeed *= -1
}
if place_meeting(x,y +vspeed,Wall){
	vspeed *= -1
}
if (speed >= 1) {
	speed /= 1.09
}
else {
speed = 0;
}
if (speed = 0) {
	gunangle = random(359);
	with instance_create(x,y,Bullet1) {
		motion_set(other.gunangle, 11)
		team = other.team
		image_angle = direction
	}
	timer -= 1
	if (timer <= 0) {
	instance_destroy();
	}
}

#define random_bullet_turret_draw
draw_sprite_ext(sprite_index, image_index, x, y, .5*image_xscale, .5*image_yscale, image_angle, image_blend, 1.0);
draw_set_blend_mode(bm_add);
draw_sprite_ext(sprite_index, image_index, x, y, 0.7*image_xscale, 0.7*image_yscale, image_angle, image_blend, 0.1);
draw_set_blend_mode(bm_normal);

#define create_bullet_cannon_turret

with instance_create(x,y,CustomProjectile) {
	motion_set(other.gunangle, 10 + random(2))
	team = other.team
	creator = other
	sprite_index = sprAllyBullet
	image_speed = 0
	timer = 400
	timer2 = 0
	on_hit = script_ref_create(actually_nothing)
	on_wall = script_ref_create(actually_nothing)
	on_step = script_ref_create(bullet_cannon_turret_step)
	on_draw = script_ref_create(bullet_cannon_turret_draw)
}

#define bullet_cannon_turret_step
scale = random_range(0.9,1.1)
image_xscale = 2*scale
image_yscale = 2*scale

if place_meeting(x + hspeed,y,Wall){
	hspeed *= -1
}
if place_meeting(x,y +vspeed,Wall){
	vspeed *= -1
}
if (speed >= 1) {
	speed /= 1.2
}
else {
speed = 0;
}
if (speed = 0) {
	if(timer2 > 1) {
		if instance_exists(enemy) gunangle = point_direction(x,y,instance_nearest(x,y,enemy).x,instance_nearest(x,y,enemy).y)
		else gunangle = random(359)
		with instance_create(x, y, CustomProjectile) {
			motion_set(other.gunangle, 8)
			sprite_index = sprAllyBullet
			image_xscale = 2
			image_yscale = 2
			typ = 1
			mask_index = mskBullet1
			damage = 20
			team = other.team
			creator = other
			recycle_amount = 10
			image_speed = 1
			image_angle = direction
			on_step = script_ref_create(bullet_step)
			on_destroy = script_ref_create(bullet_cannon_destroy)
			on_hit = script_ref_create(bullet_hit)
			on_draw = script_ref_create(bullet_draw)
		}
		timer2 -= 20;
	}
	else {
	timer2 += 1;
	}
	timer -= 1
	if (timer <= 0) {
	instance_destroy();
	}
}

#define bullet_cannon_turret_draw
draw_sprite_ext(sprite_index, image_index, x, y, 1*image_xscale, 1*image_yscale, image_angle, image_blend, 1.0);
draw_set_blend_mode(bm_add);
draw_sprite_ext(sprite_index, image_index, x, y, 1.25*image_xscale, 1.25*image_yscale, image_angle, image_blend, 0.1);
draw_set_blend_mode(bm_normal);

#define create_turret_cannon(_s, _o, _p)

with instance_create(x + lengthdir_x(_p, gunangle), y + lengthdir_y(_p, gunangle), CustomProjectile){
	motion_set(other.gunangle + (_o + random_range(_s/-2, _s/2) * other.accuracy), 6)
	sprite_index = sprAllyBullet
	image_xscale = 4
	image_yscale = 4
	typ = 1
	mask_index = mskBullet1
	damage = 40
	team = other.team
	creator = other
	recycle_amount = 10
	image_speed = 1
	image_angle = direction
	on_step = script_ref_create(bullet_step)
	on_destroy = script_ref_create(turret_cannon_destroy)
	on_hit = script_ref_create(bullet_hit)
	on_draw = script_ref_create(bullet_draw)
}

#define turret_cannon_destroy
for (var i = random_range(-59,0); i < 360 i += 60) {
	with instance_create(x,y,CustomProjectile) {
		motion_set(i, 10)
		team = other.team
		creator = other
		sprite_index = sprAllyBullet
		image_speed = 0
		timer = 150
		timer2 = 0
		on_hit = script_ref_create(actually_nothing)
		on_wall = script_ref_create(actually_nothing)
		on_step = script_ref_create(bullet_turret_step)
		on_draw = script_ref_create(bullet_turret_draw)
	}
}

#define create_turret_cannon_turret

with instance_create(x,y,CustomProjectile) {
	motion_set(other.gunangle, 10 + random(2))
	team = other.team
	creator = other
	sprite_index = sprAllyBullet
	image_speed = 0
	timer = 400
	timer2 = 0
	on_hit = script_ref_create(actually_nothing)
	on_wall = script_ref_create(actually_nothing)
	on_step = script_ref_create(turret_cannon_turret_step)
	on_draw = script_ref_create(turret_cannon_turret_draw)
}

#define turret_cannon_turret_step
scale = random_range(0.9,1.1)
image_xscale = 2*scale
image_yscale = 2*scale

if place_meeting(x + hspeed,y,Wall){
	hspeed *= -1
}
if place_meeting(x,y +vspeed,Wall){
	vspeed *= -1
}
if (speed >= 1) {
	speed /= 1.2
}
else {
speed = 0;
}
if (speed = 0) {
	if(timer2 > 1) {
		if instance_exists(enemy) gunangle = point_direction(x,y,instance_nearest(x,y,enemy).x,instance_nearest(x,y,enemy).y)
		else gunangle = random(359)
		with instance_create(x + lengthdir_x(4, gunangle), y + lengthdir_y(4, gunangle), CustomProjectile){
			motion_set(other.gunangle, 6)
			sprite_index = sprAllyBullet
			image_xscale = 4
			image_yscale = 4
			typ = 1
			mask_index = mskBullet1
			damage = 40
			team = other.team
			creator = other
			recycle_amount = 10
			image_speed = 1
			image_angle = direction
			on_step = script_ref_create(bullet_step)
			on_destroy = script_ref_create(turret_cannon_destroy)
			on_hit = script_ref_create(bullet_hit)
			on_draw = script_ref_create(bullet_draw)
		}
		timer2 -= 50;
	}
	else {
	timer2 += 1;
	}
	timer -= 1
	if (timer <= 0) {
	for (var i = 0; i < 360; i += 3) {
		with instance_create(x + lengthdir_x(8,direction), y + lengthdir_y(8,direction),Bullet1) {
			creator = other.creator 
			image_angle = direction
			motion_add(i,11) 
			team = other.team
		}
	}
	instance_destroy();
	}
}

#define turret_cannon_turret_draw
draw_sprite_ext(sprite_index, image_index, x, y, 2*image_xscale, 2*image_yscale, image_angle, image_blend, 1.0);
draw_set_blend_mode(bm_add);
draw_sprite_ext(sprite_index, image_index, x, y, 2.5*image_xscale, 2.5*image_yscale, image_angle, image_blend, 0.1);
draw_set_blend_mode(bm_normal);

#define create_small_project

with instance_create(x + lengthdir_x(4, gunangle), y + lengthdir_y(4, gunangle), CustomObject){
	motion_set(other.gunangle * other.accuracy, 11)
	sprite_index = sprAllyBullet
	image_xscale = 2
	image_yscale = 2
	typ = 1
	mask_index = mskBullet1
	damage = 20
	team = other.team
	creator = other
	recycle_amount = 10
	image_speed = 1
	image_angle = direction
	timer = 0
	lifetimer = 300
	on_step = script_ref_create(small_project_step)
	on_hit = script_ref_create(bullet_hit)
	on_draw = script_ref_create(small_project_draw)
	on_destroy = script_ref_create(small_project_destroy)
}

#define small_project_step

if place_meeting(x + hspeed,y,Wall){
	hspeed *= -1
}
if place_meeting(x,y +vspeed,Wall){
	vspeed *= -1
}

if (speed >= 0.1) {
	speed /= 1.2
}
else {
	if instance_exists(enemy) gunangle = point_direction(x,y,instance_nearest(x,y,enemy).x,instance_nearest(x,y,enemy).y)
	else {
	gunangle = random(359)
	timer -= 60
	}
	if (timer > 20) {
		with instance_create(x, y, CustomProjectile){
			motion_set(other.gunangle, 2)
			sprite_index = sprAllyBullet
			image_blend = c_purple
			typ = 2
			mask_index = mskBullet1
			damage = 6
			team = other.team
			creator = other
			recycle_amount = 2
			image_speed = 1
			image_angle = direction
			timer = 11 + irandom(8)
			image_yscale = 1.2
			image_xscale = 1.2
			on_step = script_ref_create(psy_step)
			on_destroy = script_ref_create(psy_destroy)
			on_hit = script_ref_create(bullet_hit)
			on_draw = script_ref_create(bullet_draw)
		}
		timer = 0
	}
	else {
		timer += 1.5;
	}
}
if (lifetimer < 0) {
	instance_destroy();
}
else lifetimer -= 1

#define small_project_draw

draw_sprite_ext(sprite_index, image_index, x, y, 0.6*image_xscale, 0.6*image_yscale, image_angle, c_purple, 1.0);
draw_set_blend_mode(bm_add);
draw_sprite_ext(sprite_index, image_index, x, y, 1.2*image_xscale, 1.2*image_yscale, image_angle, c_red, 0.1);
draw_set_blend_mode(bm_normal);

#define small_project_destroy
for (var i = random_range(-35,0); i < 360 i += 36) {
	with instance_create(x, y, CustomProjectile){
		motion_set(i, 2)
		sprite_index = sprAllyBullet
		image_blend = c_purple
		typ = 2
		mask_index = mskBullet1
		damage = 6
		team = other.team
		creator = other
		recycle_amount = 2
		image_speed = 1
		image_angle = direction
		timer = 11 + irandom(8)
		image_yscale = 1.2
		image_xscale = 1.2
		on_step = script_ref_create(psy_step)
		on_destroy = script_ref_create(psy_destroy)
		on_hit = script_ref_create(bullet_hit)
		on_draw = script_ref_create(bullet_draw)
	}
}

#define create_science_project

with instance_create(x + lengthdir_x(4, gunangle), y + lengthdir_y(4, gunangle), CustomObject){
	motion_set(other.gunangle * other.accuracy, 13)
	sprite_index = sprAllyBullet
	image_xscale = 3.5
	image_yscale = 3.5
	typ = 1
	mask_index = mskBullet1
	damage = 40
	team = other.team
	creator = other
	recycle_amount = 10
	image_speed = 1
	image_angle = direction
	timer = 0
	lifetimer = 500
	on_step = script_ref_create(science_project_step)
	on_hit = script_ref_create(bullet_hit)
	on_draw = script_ref_create(science_project_draw)
	on_destroy = script_ref_create(science_project_destroy)
}

#define science_project_step

if place_meeting(x + hspeed,y,Wall){
	hspeed *= -1
}
if place_meeting(x,y +vspeed,Wall){
	vspeed *= -1
}

if (speed >= 0.1) {
	speed /= 1.18
}
else {
	if instance_exists(enemy) gunangle = point_direction(x,y,instance_nearest(x,y,enemy).x,instance_nearest(x,y,enemy).y)
	else {
	gunangle = random(359)
	lifetimer -= 80
	}
	if (timer > 9) {
		with instance_create(x, y, CustomProjectile){
			motion_set(other.gunangle - 15, 2)
			sprite_index = sprAllyBullet
			image_blend = c_purple
			typ = 2
			mask_index = mskBullet1
			damage = 6
			team = other.team
			creator = other
			recycle_amount = 2
			image_speed = 1
			image_angle = direction
			timer = 11 + irandom(8)
			image_yscale = 1.2
			image_xscale = 1.2
			on_step = script_ref_create(psy_step)
			on_destroy = script_ref_create(psy_destroy)
			on_hit = script_ref_create(bullet_hit)
			on_draw = script_ref_create(bullet_draw)
		}
		with instance_create(x, y, CustomProjectile){
			motion_set(other.gunangle + 15, 2)
			sprite_index = sprAllyBullet
			image_blend = c_purple
			typ = 2
			mask_index = mskBullet1
			damage = 6
			team = other.team
			creator = other
			recycle_amount = 2
			image_speed = 1
			image_angle = direction
			timer = 11 + irandom(8)
			image_yscale = 1.2
			image_xscale = 1.2
			on_step = script_ref_create(psy_step)
			on_destroy = script_ref_create(psy_destroy)
			on_hit = script_ref_create(bullet_hit)
			on_draw = script_ref_create(bullet_draw)
		}
		if (random(8) < 1) {
			with instance_create(x,y,CustomProjectile) {
				motion_set(other.gunangle, 2.5)
				sprite_index = sprRocket
				image_xscale = 0.2
				image_yscale = 0.2
				typ = 2
				mask_index = mskBullet1
				damage = 6
				team = other.team
				creator = other
				recycle_amount = 2
				image_speed = 1
				image_angle = direction
				timer = 11 + irandom(8)
				image_yscale = 1.2
				image_xscale = 1.2
				on_step = script_ref_create(actually_nothing)
				on_destroy = script_ref_create(rocket_destroy)
				on_hit = script_ref_create(bullet_hit)
				on_draw = script_ref_create(bullet_draw)
			}
		}
		timer = 0
	}
	else {
		timer += 2;
	}
}
if (lifetimer < 0) {
	instance_destroy();
}
else lifetimer -= 1

#define science_project_draw

draw_sprite_ext(sprite_index, image_index, x, y, 0.7*image_xscale, 0.7*image_yscale, image_angle, c_purple, 1.0);
draw_set_blend_mode(bm_add);
draw_sprite_ext(sprite_index, image_index, x, y, 1.4*image_xscale, 1.4*image_yscale, image_angle, c_red, 0.1);
draw_set_blend_mode(bm_normal);

#define science_project_destroy
for (var i = random_range(-35,0); i < 360 i += 8) {
	with instance_create(x, y, CustomProjectile){
		motion_set(i, 2)
		sprite_index = sprAllyBullet
		image_blend = c_purple
		typ = 2
		mask_index = mskBullet1
		damage = 6
		team = other.team
		creator = other
		recycle_amount = 2
		image_speed = 1
		image_angle = direction
		timer = 11 + irandom(8)
		image_yscale = 1.2
		image_xscale = 1.2
		on_step = script_ref_create(psy_step)
		on_destroy = script_ref_create(psy_destroy)
		on_hit = script_ref_create(bullet_hit)
		on_draw = script_ref_create(bullet_draw)
	}
}

#define create_big_project

with instance_create(x + lengthdir_x(4, gunangle), y + lengthdir_y(4, gunangle), CustomObject){
	motion_set(other.gunangle * other.accuracy, 13)
	sprite_index = sprAllyBullet
	image_xscale = 4.5
	image_yscale = 4.5
	typ = 1
	mask_index = mskBullet1
	damage = 75
	team = other.team
	creator = other
	recycle_amount = 10
	image_speed = 1
	image_angle = direction
	timer = 0
	lifetimer = 650
	on_step = script_ref_create(big_project_step)
	on_hit = script_ref_create(bullet_hit)
	on_draw = script_ref_create(big_project_draw)
	on_destroy = script_ref_create(big_project_destroy)
}

#define big_project_step

if place_meeting(x + hspeed,y,Wall){
	hspeed *= -1
}
if place_meeting(x,y +vspeed,Wall){
	vspeed *= -1
}

if (speed >= 0.1) {
	speed /= 1.17
}
else {
	if instance_exists(enemy) gunangle = point_direction(x,y,instance_nearest(x,y,enemy).x,instance_nearest(x,y,enemy).y)
	else {
	gunangle = random(359)
	timer -= 100
	}
	if (timer > 5) {
		with instance_create(x, y, CustomProjectile){
			motion_set(other.gunangle, 2)
			sprite_index = sprAllyBullet
			image_blend = c_purple
			typ = 2
			mask_index = mskBullet1
			damage = 6
			team = other.team
			creator = other
			recycle_amount = 2
			image_speed = 1
			image_angle = direction
			timer = 11 + irandom(8)
			image_yscale = 1.2
			image_xscale = 1.2
			on_step = script_ref_create(psy_step)
			on_destroy = script_ref_create(psy_destroy)
			on_hit = script_ref_create(bullet_hit)
			on_draw = script_ref_create(bullet_draw)
		}
		with instance_create(x, y, CustomProjectile){
			motion_set(other.gunangle + 30, 2)
			sprite_index = sprAllyBullet
			image_blend = c_purple
			typ = 2
			mask_index = mskBullet1
			damage = 6
			team = other.team
			creator = other
			recycle_amount = 2
			image_speed = 1
			image_angle = direction
			timer = 11 + irandom(8)
			image_yscale = 1.2
			image_xscale = 1.2
			on_step = script_ref_create(psy_step)
			on_destroy = script_ref_create(psy_destroy)
			on_hit = script_ref_create(bullet_hit)
			on_draw = script_ref_create(bullet_draw)
		}
		with instance_create(x, y, CustomProjectile){
			motion_set(other.gunangle - 30, 2)
			sprite_index = sprAllyBullet
			image_blend = c_purple
			typ = 2
			mask_index = mskBullet1
			damage = 6
			team = other.team
			creator = other
			recycle_amount = 2
			image_speed = 1
			image_angle = direction
			timer = 11 + irandom(8)
			image_yscale = 1.2
			image_xscale = 1.2
			on_step = script_ref_create(psy_step)
			on_destroy = script_ref_create(psy_destroy)
			on_hit = script_ref_create(bullet_hit)
			on_draw = script_ref_create(bullet_draw)
		}
		if (random(3) < 1) {
			with instance_create(x,y,CustomProjectile) {
				motion_set(other.gunangle + random_range(-10,10), 3)
				sprite_index = sprRocket
				image_xscale = 0.2
				image_yscale = 0.2
				typ = 2
				mask_index = mskBullet1
				damage = 6
				team = other.team
				creator = other
				recycle_amount = 2
				image_speed = 1
				image_angle = direction
				timer = 11 + irandom(8)
				image_yscale = 1.2
				image_xscale = 1.2
				on_step = script_ref_create(actually_nothing)
				on_destroy = script_ref_create(rocket_destroy)
				on_hit = script_ref_create(bullet_hit)
				on_draw = script_ref_create(bullet_draw)
			}
		}
		timer = 0
	}
	else {
		timer += 2.5;
	}
}
if (lifetimer < 0) {
	instance_destroy();
}
else lifetimer -= 1

#define big_project_draw

draw_sprite_ext(sprite_index, image_index, x, y, 0.9*image_xscale, 0.9*image_yscale, image_angle, c_purple, 1.0);
draw_set_blend_mode(bm_add);
draw_sprite_ext(sprite_index, image_index, x, y, 1.8*image_xscale, 1.8*image_yscale, image_angle, c_red, 0.1);
draw_set_blend_mode(bm_normal);

#define big_project_destroy
for (var i = random_range(-21.5,0); i < 360 i += 22.5) {
	with instance_create(x, y, CustomProjectile){
		motion_set(i, 3)
		sprite_index = sprAllyBullet
		image_xscale = 2
		image_yscale = 2
		image_blend = c_purple
		typ = 1
		mask_index = mskBullet1
		damage = 20
		timer = 5
		team = other.team
		creator = other
		recycle_amount = 10
		image_speed = 1
		image_angle = direction
		on_step = script_ref_create(psy_step)
		on_destroy = script_ref_create(psy_cannon_destroy)
		on_hit = script_ref_create(bullet_hit)
		on_draw = script_ref_create(bullet_draw)
	}
}

#define create_primordial_project

with instance_create(x + lengthdir_x(4, gunangle), y + lengthdir_y(4, gunangle), CustomObject){
	motion_set(other.gunangle * other.accuracy, 14)
	sprite_index = sprAllyBullet
	image_xscale = 5
	image_yscale = 5
	typ = 1
	mask_index = mskBullet1
	damage = 80
	team = other.team
	creator = other
	recycle_amount = 10
	image_speed = 1
	image_angle = direction
	timer = 0
	lifetimer = 700
	on_step = script_ref_create(primordial_project_step)
	on_hit = script_ref_create(bullet_hit)
	on_draw = script_ref_create(big_project_draw)
	on_destroy = script_ref_create(primordial_project_destroy)
}

#define primordial_project_step

if place_meeting(x + hspeed,y,Wall){
	hspeed *= -1
}
if place_meeting(x,y +vspeed,Wall){
	vspeed *= -1
}

if (speed >= 0.1) {
	speed /= 1.17
}
else {
	if instance_exists(enemy) gunangle = point_direction(x,y,instance_nearest(x,y,enemy).x,instance_nearest(x,y,enemy).y)
	else {
	gunangle = random(359)
	timer -= 200
	}
	if (timer > 8) {
		for (var i = -60; i < 60 i += 20) {
			with instance_create(x + lengthdir_x(4, gunangle), y + lengthdir_y(4, gunangle), CustomProjectile){
				motion_set(i + other.gunangle, 4)
				sprite_index = sprBouncerBullet
				image_blend = c_purple
				image_xscale = 0.9
				image_yscale = 0.9
				typ = 1
				mask_index = mskBullet1
				damage = 9
				team = other.team
				creator = other
				recycle_amount = 10
				timer = 10
				image_speed = 1
				image_angle = direction
				on_step = script_ref_create(psy_bouncer_step)
				on_destroy = script_ref_create(psy_bouncer_destroy)
				on_hit = script_ref_create(bullet_hit)
				on_draw = script_ref_create(bullet_draw)
			}
		}
		if (random(3) < 1) {
			repeat(1 + random(1)) {
				with instance_create(x,y,CustomProjectile) {
					motion_set(other.gunangle + random_range(-10,10), 3)
					sprite_index = sprRocket
					image_xscale = 0.2
					image_yscale = 0.2
					typ = 2
					mask_index = mskBullet1
					damage = 6
					team = other.team
					creator = other
					recycle_amount = 2
					image_speed = 1
					image_angle = direction
					timer = 11 + irandom(8)
					image_yscale = 1.2
					image_xscale = 1.2
					on_step = script_ref_create(actually_nothing)
					on_destroy = script_ref_create(rocket_destroy)
					on_hit = script_ref_create(bullet_hit)
					on_draw = script_ref_create(bullet_draw)
				}
			}
		}
		timer = 0
	}
	else {
		timer += 2.5;
	}
}
if (lifetimer < 0) {
	instance_destroy();
}
else lifetimer -= 1

#define primordial_project_draw

draw_sprite_ext(sprite_index, image_index, x, y, 1*image_xscale, 1*image_yscale, image_angle, c_purple, 1.0);
draw_set_blend_mode(bm_add);
draw_sprite_ext(sprite_index, image_index, x, y, 2*image_xscale, 2*image_yscale, image_angle, c_red, 0.1);
draw_set_blend_mode(bm_normal);

#define primordial_project_destroy
for (var i = random_range(-21.5,0); i < 360 i += 20) {
	with instance_create(x + lengthdir_x(4, gunangle), y + lengthdir_y(4, gunangle), CustomProjectile){
		motion_set(i, 2.8)
		sprite_index = sprAllyBullet
		image_xscale = 2.2
		image_yscale = 2.2
		image_blend = c_purple
		typ = 1
		mask_index = mskBullet1
		damage = 22
		team = other.team
		creator = other
		recycle_amount = 10
		image_speed = 1
		image_angle = direction
		on_step = script_ref_create(bullet_step)
		on_destroy = script_ref_create(psy_bouncer_cannon_destroy)
		on_hit = script_ref_create(bullet_hit)
		on_draw = script_ref_create(bullet_draw)
	}
}

#define create_psy_cannon

with instance_create(x + lengthdir_x(4, gunangle), y + lengthdir_y(4, gunangle), CustomProjectile){
	motion_set(other.gunangle * other.accuracy, 3)
	sprite_index = sprAllyBullet
	image_xscale = 2
	image_yscale = 2
	image_blend = c_purple
	typ = 1
	mask_index = mskBullet1
	damage = 20
	team = other.team
	creator = other
	recycle_amount = 10
	image_speed = 1
	image_angle = direction
	on_step = script_ref_create(bullet_step)
	on_destroy = script_ref_create(psy_cannon_destroy)
	on_hit = script_ref_create(bullet_hit)
	on_draw = script_ref_create(bullet_draw)
}

#define psy_cannon_destroy
for (var i = random_range(-19,0); i < 360 i += 20) {
	with instance_create(x, y, CustomProjectile){
		motion_set(i, 2)
		sprite_index = sprAllyBullet
		image_blend = c_purple
		typ = 2
		mask_index = mskBullet1
		damage = 6
		team = other.team
		creator = other
		recycle_amount = 2
		image_speed = 1
		image_angle = direction
		timer = 11 + irandom(8)
		image_yscale = 1.2
		image_xscale = 1.2
		on_step = script_ref_create(psy_step)
		on_destroy = script_ref_create(psy_destroy)
		on_hit = script_ref_create(bullet_hit)
		on_draw = script_ref_create(bullet_draw)
	}
}

#define create_psy_bouncer_cannon

with instance_create(x + lengthdir_x(4, gunangle), y + lengthdir_y(4, gunangle), CustomProjectile){
	motion_set(other.gunangle * other.accuracy, 2.8)
	sprite_index = sprAllyBullet
	image_xscale = 2.2
	image_yscale = 2.2
	image_blend = c_purple
	typ = 1
	mask_index = mskBullet1
	damage = 22
	team = other.team
	creator = other
	recycle_amount = 10
	timer = 10
	image_speed = 1
	image_angle = direction
	on_step = script_ref_create(psy_step)
	on_destroy = script_ref_create(psy_bouncer_cannon_destroy)
	on_hit = script_ref_create(bullet_hit)
	on_draw = script_ref_create(bullet_draw)
}

#define psy_bouncer_cannon_destroy
for (var i = random_range(-19,0); i < 360 i += 20) {
	with instance_create(x, y, CustomProjectile){
		motion_set(i, 4)
		image_xscale = 0.9
		image_yscale = 0.9
		sprite_index = sprBouncerBullet
		image_blend = c_purple
		typ = 1
		mask_index = mskBullet1
		damage = 9
		team = other.team
		creator = other
		recycle_amount = 10
		timer = 10
		image_speed = 1
		image_angle = direction
		on_step = script_ref_create(psy_bouncer_step)
		on_destroy = script_ref_create(psy_bouncer_destroy)
		on_hit = script_ref_create(bullet_hit)
		on_draw = script_ref_create(bullet_draw)
	}
}

#define create_psy_bouncer

with instance_create(x + lengthdir_x(4, gunangle), y + lengthdir_y(4, gunangle), CustomProjectile){
	motion_set(other.gunangle * other.accuracy, 4)
	sprite_index = sprBouncerBullet
	image_blend = c_purple
	image_xscale = 0.9
	image_yscale = 0.9
	typ = 1
	mask_index = mskBullet1
	damage = 9
	team = other.team
	creator = other
	recycle_amount = 10
	timer = 10
	image_speed = 1
	image_angle = direction
	on_step = script_ref_create(psy_bouncer_step)
	on_destroy = script_ref_create(psy_bouncer_destroy)
	on_hit = script_ref_create(bullet_hit)
	on_draw = script_ref_create(bullet_draw)
}

#define rocket_destroy
	
instance_create(x,y,Explosion) {}
	
#define psy_bouncer_step

if (instance_exists(enemy)) {
	if place_meeting(x + hspeed,y,Wall){
		hspeed *= -1
	}
	if place_meeting(x,y +vspeed,Wall){
		vspeed *= -1
	}
}

if timer > 0{
	timer -= 1
}

if timer = 0 && instance_exists(enemy){
	var closeboy = instance_nearest(x,y,enemy)
	if collision_line(x,y,closeboy.x,closeboy.y,Wall,0,0) < 0 && distance_to_object(closeboy) < 140{
		motion_add(point_direction(x,y,closeboy.x,closeboy.y),.6)
		motion_add(direction,-.03)
		image_angle = direction
	}
}
if image_index >= 1{
	image_speed = 0
}

#define psy_bouncer_destroy
with instance_create(x,y,BulletHit){
	image_angle = other.direction + 180
}
if place_meeting(x + hspeed,y +vspeed,Wall){sound_play(sndHitWall)}

#define psy_step
if timer > 0{
	timer -= 1
}
if timer = 0 && instance_exists(enemy){
	var closeboy = instance_nearest(x,y,enemy)
	if collision_line(x,y,closeboy.x,closeboy.y,Wall,0,0) < 0 && distance_to_object(closeboy) < 200{
		motion_add(point_direction(x,y,closeboy.x,closeboy.y),.54)
		motion_add(direction,-.02)
		image_angle = direction
	}
}
if image_index >= 1{
	image_speed = 0
}

#define psy_destroy
with instance_create(x,y,BulletHit){
	image_angle = other.direction + 180
}
if place_meeting(x + hspeed,y +vspeed,Wall){sound_play(sndHitWall)}

#define create_ultra_seeker

with instance_create(x + lengthdir_x(2, gunangle), y + lengthdir_y(2, gunangle), CustomProjectile) {
	motion_set(other.gunangle + (random(120) - 60) * other.accuracy, 3.5)
	sprite_index = sprUltraBolt
	damage = 50
	image_angle = direction
	team = other.team
	creator = other
	on_step = script_ref_create(ultra_seeker_step)
	on_destroy = script_ref_create(ultra_seeker_destroy)
}

#define ultra_seeker_step
do {
	var t = instance_nearest(x, y, hitme);
	if (t && (t.team == team || instance_is(t, prop) && t.object_index != Generator)) {
		t = instance_nearest(x, y, enemy);
		if (t && t.team == team) t = noone;
	}
	if (t) {
		var tx = t.x, ty = t.y;
		if (!collision_line(x, y, tx, ty, Wall, 0, 0)) {
			var dir = point_direction(x, y, tx, ty);
			motion_add(point_direction(x, y, tx, ty),
				0.5 + (point_distance(x, y, tx, ty) < 48 + skill_get(21) * 48) * 4);
		}
		image_angle = direction;
	}
	direction += random(4) - 2;
	speed = 4 + random(4);
	wait 1;
} while (instance_exists(self));

#define ultra_seeker_destroy

for (var i = random_range(-59, 0); i < 360; i += 360) {
	with instance_create(x + lengthdir_x(2, direction), y + lengthdir_y(2, direction), Seeker) {
		team = other.team
		motion_add(i, 3)
		image_angle = direction
	}
}

#define create_dark_bullet(_s, _o, _p)
with instance_create(x + lengthdir_x(_p, gunangle), y + lengthdir_y(_p, gunangle), CustomProjectile){
	motion_set(other.gunangle + (_o + random_range(_s/-2, _s/2) * other.accuracy), 11)
	sprite_index = global.sprDarkBullet
	typ = 2
	mask_index = mskBullet1
	damage = 3
	team = other.team
	creator = other
	recycle_amount = 2
	image_speed = 1
	image_angle = direction
	on_step = script_ref_create(bullet_step)
	on_destroy = script_ref_create(dark_destroy)
	on_hit = script_ref_create(bullet_hit)
	on_draw = script_ref_create(bullet_draw)
}

#define dark_destroy
with instance_create(x,y,SmallExplosion) {
	sound_play(Explosion)
	sprite_index = global.sprDarkSmallExplosion
	creator = other.creator
}
