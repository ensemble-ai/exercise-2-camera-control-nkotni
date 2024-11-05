# Code Review for Programming Exercise 2 #

## Peer-Reviewer Information

* *name:* Chase Keighley
* *email:* crkeighley@ucdavis.edu

### Description ###

To assess the solution, you will be choosing ONE choice from unsatisfactory, satisfactory, good, great, or perfect. Place an x character inside of the square braces next to the appropriate label.

The following are the criteria by which you should assess your peer's solution of the exercise's stages.

#### Perfect #### 
    Cannot find any flaws concerning the prompt. Perfectly satisfied all stage objectives.

#### Great ####
    Minor flaws in one or two objectives. 

#### Good #####
    A major flaw and some minor flaws.

#### Satisfactory ####
    A couple of major flaws. Heading towards a solution, however, did not fully realize the solution.

#### Unsatisfactory ####
    Partial work, but not really converging to a solution. Pervasive major flaws. Objective largely unmet.

## Solution Assessment ##

### Stage 1 ###

- [x] Perfect
- [ ] Great
- [ ] Good
- [ ] Satisfactory
- [ ] Unsatisfactory

#### Justification ##### 
Vessel remains centered on screen with position lock camera. A cross hair can be toggled marking the center location accurately.

### Stage 2 ###

- [x] Perfect
- [ ] Great
- [ ] Good
- [ ] Satisfactory
- [ ] Unsatisfactory

#### Justification ##### 
Vessel cannot breach the bounds of the autoscroll camera box, remaining perefectly at each edge when attempting to go outside box. The vessel's speed is also made proportional to camera movement, allowing vessel control to feel relatively no different than without the autoscroll. This is a valid gameplay feel change that the programmer added. The bounds of the autoscroll box have appropriate proportions and can be toggled successfully.

### Stage 3 ###

- [x] Perfect
- [ ] Great
- [ ] Good
- [ ] Satisfactory
- [ ] Unsatisfactory

#### Justification ##### 
This stage successfully meets all requirements: when unmoving, vessel remains centered on screen with position lock. When moving, the camera lags behind at a slower speed initially and at vessel speed once a certain leash distance away, and finally catches up when vessel stops. A cross hair can be toggled marking the camera's center accurately.

### Stage 4 ###

- [x] Perfect
- [ ] Great
- [ ] Good
- [ ] Satisfactory
- [ ] Unsatisfactory

#### Justification ##### 
This stage also successfully meets all requirements: when moving, the camera leads in front of the vessel and in the same direction as vessel velocity at a faster speed initially and at vessel speed once a certain leash distance away. When vessel stops, the camera pauses for a given delay and then centers smoothly on the vessel. A cross hair can be toggled marking the camera's center accurately.

### Stage 5 ###

- [ ] Perfect
- [ ] Great
- [x] Good
- [ ] Satisfactory
- [ ] Unsatisfactory

#### Justification ##### 
This stage successfully meets multiple requirements. The vessel cannot breach the bounds of the outer push box and camera moves at vessel speed in the direction of the wall being pushed including two walls at once. When passing an inner speedup bound, the camera appropriately moves at push ratio multiplied by vessel speed in direction of bound being passed. Also the camera does not move when vessel is contained by speedup zone. The bounds of both outer pushbox and speedup box have appropriate proportions and can be toggled on and off. However, one flaw is that when vessel is between the speedup bound and outer pushbox bound, the camera is able to move perpendicular to the wall it's close to, which is incorrect behavior. For example, if vessel is between left bounds and moves up or down (even if not in a corner) the camera will also move up or down.

## Code Style ##

### Style Guide Infractions ###

Occassionally inconsistent line spaces within functions: [two lines](https://github.com/ensemble-ai/exercise-2-camera-control-nkotni/blob/3e5babba64eb105596c57327472943057002178e/Obscura/scripts/camera_controllers/position_lock.gd#L41), [three lines](https://github.com/ensemble-ai/exercise-2-camera-control-nkotni/blob/3e5babba64eb105596c57327472943057002178e/Obscura/scripts/camera_controllers/lerp_target.gd#L65). This is a small infraction which appears in multiple scripts and can lead to indistinction between code within functions and separation between functions.

[Three lines separating functions](https://github.com/ensemble-ai/exercise-2-camera-control-nkotni/blob/3e5babba64eb105596c57327472943057002178e/Obscura/scripts/camera_controllers/lock_lerp.gd#L73) or [one line](https://github.com/ensemble-ai/exercise-2-camera-control-nkotni/blob/3e5babba64eb105596c57327472943057002178e/Obscura/scripts/camera_controllers/four_way_push.gd#L13). This is not seen too often code however.

### Style Guide Exemplars ###

Overall style is very consistent, clean and legible. Variables are declared in proper order and safely typed. Proper spacing between operators is maintained.

## Best Practices ##

### Best Practices Infractions ###

There are only a couple commits to the repository; more commits could be beneficial and in line with best practice.

[This conditional statement](https://github.com/ensemble-ai/exercise-2-camera-control-nkotni/blob/3e5babba64eb105596c57327472943057002178e/Obscura/scripts/camera_controllers/lerp_target.gd#L46) could benefit from some comments, as there are a lot of nested ifs and math/logic.

### Best Practices Exemplars ###

Comments throughout code give sufficient guidance and explanations.

Variable [catchup_speed](https://github.com/ensemble-ai/exercise-2-camera-control-nkotni/blob/3e5babba64eb105596c57327472943057002178e/Obscura/scripts/camera_controllers/lock_lerp.gd#L8) is dependent on target.BASE_SPEED which allows for good dynamic code and prevents potential errors if target.BASE_SPEED changes.
