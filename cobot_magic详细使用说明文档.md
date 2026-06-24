#  cobot_magic详细使用说明文档

- **工控机(4090显卡版,4060显卡版):** 支持机械臂遥操作、采集数据、支持模型训练、支持模型推理
- ACT模型训练建议使用**高算力大显存服务器**, 4060显卡训练 50 episode、500 timesteps的数据集,batch-size给4都会出现显存不足。4060可用于推理
- **遇到问题可参考本手册进行排查（机械臂部分、底盘部分、软件环境部分）。排查结果可联系松灵售后技术支持团队。**
- **出厂时已经配置好了软件环境！！！**

**拿到设备后，按照第1章第1节接好线，从第3章“采集数据”开始操作**

------

## 1 上电配置

### 1.1 电气连接

![img](https://cdn.nlark.com/yuque/0/2025/png/33709251/1746513363504-5a833eb6-1dd4-4bf7-aea0-639c0dbe07b9.png)

#### 1.1.1 设备开机操作

1. 先将机械臂水平放置，夹爪，示教器手动重置为闭合状态。**每次上电，请先将机械臂恢复到下图正确位置再上电。如果不在正确位置上电，可能导致机械臂零点改变，注意：上电前保证J1刻度对齐**。![null](C:\Users\zhihui.qin\AppData\Roaming\Typora\typora-user-images\image-20250429114128680.png) 

![img](https://cdn.nlark.com/yuque/0/2025/png/33709251/1746513531353-3c0ab08f-c93b-413f-89fb-6d8f04dd1b5e.png)

1. 先按下户外电源**主开关**，再按一下**AC开关**，此时工控机和机械臂会正常上电。
2. 再按下底盘的电源开关，**屏幕、路由器和USB拓展坞由底盘供电。**

![img](https://cdn.nlark.com/yuque/0/2025/png/33709251/1747302964291-75e9be2d-1bc4-411f-81b5-afdb2c47ae65.png)

**注：tracer2.0的电源开关在底盘的正前方。**

#### *1.1.2 电气连接说明：*

- 户外电源“电小二”：右侧橙色线是它的充电线，从上往下第一个按钮是总电源按钮，ac开关是输出220v交流电开关按钮。
- 工控机：插在“电小二”上黑色的插头是它的电源适配器插头，通过电小二输出的220v交流电供电。
- 机械臂：插在“电小二”上白色的插头是它的电源适配器插头，通过电小二输出的220v交流电供电。

（**注意：机械臂和工控机的插头可以插在220v插排上取电**）

cobot_magic的电气拓扑图如下图所示：

![null](D:\agx-arm\aloha_doc\image\image-电气拓扑.png)![img](https://cdn.nlark.com/yuque/0/2025/png/33709157/1756109673948-0c01c36d-ac64-44f1-8091-749a77c03a47.png)

-**工控机开机密码为: agx**

-**路由器WiFi名称：aloha   密码：12345678**

**下图为出厂接线图，拿到工控机请按照下图所示接线**

- 选配了雷达的设备**请勿更改网线网口位置**，出厂有做网口绑定。
- 左臂，右臂和底盘的USB口都有做绑定USB设备口，每条usb线都贴有标签，**请勿变动位置，变更会导致can激活异常。**
- 通电后，工控机会自动开机,工控机左侧工作指示灯会亮起。
- 显示器输出HDMI(DP)线请插入显卡上的HDMI或者DP接口处, 如下图所示。
- ![img](https://cdn.nlark.com/yuque/0/2025/png/33709251/1746517585114-c94caf26-0bbb-40f4-9680-5a5093ea8860.png)

### 1.2机械臂接线

出厂时已经接好机械臂的线，开机只需按下户外电源**AC接口**，参考1.1电气连接。

若发生异常情况，需要给机械臂断电，可以通过按下白色插排的电源按钮。

![img](https://cdn.nlark.com/yuque/0/2025/png/33709251/1746517189988-c4449866-c8e6-440d-8023-9074968a14e9.png)

接通电源后,如下图所示，4条机械臂底座指示灯均亮起绿灯闪烁即表示通电成功,若未亮起绿灯，则检查机械臂供电。

![img](https://cdn.nlark.com/yuque/0/2025/png/33709251/1746517230532-f8057708-0325-4fab-8a28-3bb3097f1df5.png)

完成机械臂硬件连接并接通电源后，即可实现摇操功能。

## 2 软件环境配置

**此章节的操作出厂前已配置完毕，无需重新配置。**

**正常使用时请跳过这一章节，直接从3.2节“数据采集”开始！！！**

**正常使用时请跳过这一章节，直接从3.2节“数据采集”开始！！！**

**正常使用时请跳过这一章节，直接从3.2节“数据采集”开始！！！**

**相机部分和机械臂部分检修主体流程可从此章节开始。**

- cobot_magic的工控机(4060显卡、4090显卡版本),镜像自带ubuntu-20.04、ros1-noetic、cuda-11.3、torch-1.10、conda、python-3.8

1. 数据采集基础配置：ubuntu-20.04、ros1-noetic
2. 模型训练推理配置：1. ubuntu-20.04、ros1-noetic、cuda-11.3、torch-1.10(cuda-11.8、torch-2.1.1), conda,python-3.8, 已测试通过，cuda、torch其他版本请用户自己测试。

### 2.1 相机配置

**Cobot_magic相机部分检修主体流程可参考此节。**

**2.1.1 大白DC1**

**(1) 大白DC1相机参数**

| Baseline     | 40mm                                           |
| ------------ | ---------------------------------------------- |
| 深度距离     | 0.3-3m                                         |
| 深度图分辨率 | 640x400x30fps、320x200x30fps                   |
| 彩色图分辨率 | 1920x1080x30fps、1280x720x30fps、640x480x30fps |
| 精度         | 6mm@1m (81%FOV区域参与精度计算)                |
| 深度FOV      | H 67.9° V 45.3°                                |
| 彩色FOV      | H 71° V 43.7° @ 1920x1080                      |
| 延迟         | 30-45ms                                        |
| 数据传输     | USB2.0或以上                                   |
| 工作温度     | 10°C~40°C                                      |
| 尺寸         | 长59.5x宽17.4x厚11.1 mm                        |

**（2）绑定多相机（注意：未更换相机不用执行此步骤！！）**

```python
## 1.1  相机序列号查询,方法2
## cobot_magic/tools目录下camera_serial.sh脚本, 注意路径,如果没有该文件就使用方法1
## 1.1.1 进入cobot_magic目录
cd ~/cobot_magic
## 1.1.2 关闭可能的相机节点，避免USB占用
pkill -f ros
## 1.1.3 运行该脚本
./tools/camera_serial.sh
##如果是realsense相机，则运行：
./tools/rs_camera_serial.sh
# 此时终端将会打印3个相机的序列号.

# 2 修改multi_camera.launch配置文件
## 修改camera_ws/src/ros_astra_camera/launch/multi_camera.launch第13行左右相机的Serial number值
## 将1中输出的3个Serial number值,分别填入下面代码中即可
<arg name="camera1_serila_number" default="AU1231201GE"/>
<arg name="camera2_serila_number" default="AU1953304F2"/>
<arg name="camera3_serila_number" default="AU1P32201SA"/>
```

**(3) 运行**

配置好相机节点后，可按以下方法启动相机。

```python
# 1 启动相机
大白DC1相机：roslaunch astra_camera multi_camera.launch
# 2 打开rqt_image_view查看图像
rqt_image_view
## 显示如下图, 注意先刷新再选择对应的话题即可显示图像
```

![img](https://cdn.nlark.com/yuque/0/2025/png/33709251/1746517696213-4f9f33ba-bab4-4cf0-9046-ba254716a135.png)

**2.1.2 Intel Realsense**

**(1) D435 /D405相机参数**

### 2.2 机械臂配置

**ps:出厂时，工控机已经配置好机械臂运行的环境。**若非环境损坏，可跳过2.2.1小节。

**Cobot_magic机械臂部分检修主体流程可参考此节。**

#### 2.2.1 环境安装

##### 1. 安装依赖

```python
sudo apt install can-utils net-tools libkdl-parser-dev ethtool -y
```

##### 2. 机械臂can模块配置(首次配置或更换can设备的USB接口配置)

agx4条机械臂总共2个usb转can模块，需要以下教程来配置

在`can_config.sh`中，`EXPECTED_CAN_COUNT`参数一般设置为`3`( **第95行**），因为四条机械臂使用2个can模块（左臂映射名can_left，右臂映射名can_right)，底盘使用1个can模块(底盘映射名can0）。

机械臂按顺序依次进行以下操作：

- 机械臂上电。
- 拔掉所有usb转can设备（底盘，左臂，右臂的USB）。
- 按底盘usb、左臂usb和右臂usb的顺序插入工控机。
- 终端执行bash find_all_can_port.sh，此时终端会输出can0、can1 和can2的usb地址。

```shell
cd ~/cobot_magic/Piper_ros_private-ros-noetic/
bash find_all_can_port.sh # 寻找工控机上的USB转can模块。正常会输出can0、can1和can2三个地址。
```

由于刚才按顺序插入，所以映射名和can设备对应关系为（**can0->can0，can1->can_left，can2->can_right**)将三个can对应 的usb硬件地址填入臂的can配置脚本中即可（**第111行-第113行**）。

```shell
gedit can_config.sh
```

![null](D:\agx-arm\aloha_doc\image\image-20241009085001912.png)![img](https://cdn.nlark.com/yuque/0/2025/png/33709251/1746517744684-362df09d-6727-4aef-b3da-6e8d98f27b4c.png)

- 执行`bash can_config.sh`,输入密码agx后查看3个can设备是否激活成功。
- 执行`ifconfig | grep can`查看是不是有`can0`，`can_left`，和`can_right`，如果有则can模块激活成功。

**注意：**

**每次开机或每次拔插can模块后，都需执行**

```shell
cd cobot_magic/Piper_ros_private-ros-noetic/
bash can_config.sh
```

**如果更换了usb端口，请按以上步骤重新配置CAN模块。**

通过can_config.sh激活can模块成功后，可通过以下指令检查机械臂的can数据是否能传入工控机。

```shell
candump can_left # 检查左臂can数据，正常情况下，终端会有2A1等帧数据不断滚动
candump can_right # 检查右臂can数据，正常情况下，终端会有2A1等帧数据不断滚动
```

#### 2.2.2 仅获取主从机械臂关节消息（采集数据，获取机械臂反馈）

```shell
cd ~/cobot_magic/Piper_ros_private-ros-noetic/
source devel/setup.bash # 刷新环境变量
roslaunch piper start_ms_piper.launch mode:=0 auto_enable:=false # 启动机械臂节点(数采参数）
```

然后执行

```shell
rostopic list
```

有如下几个topic：

```shell
/master/joint_left
/master/joint_right
/puppet/arm_status_left
/puppet/arm_status_right
/puppet/joint_left
/puppet/joint_right
/puppet/end_pose_left
/puppet/end_pose_right
/puppet/end_pose_euler_left
/puppet/end_pose_euler_right
```

其中`/master/joint_left`、`/master/joint_right`、`/puppet/joint_left`、`/puppet/joint_right`可以读取到主臂和从臂的关节数据，例如

```shell
rostopic echo /puppet/joint_left # 读取左从臂关节数据，正常情况下，控制左臂运动，终端数据会一直刷新
rostopic echo /puppet/joint_right # 读取右从臂关节数据，正常情况下，控制左臂运动，终端数据会一直刷新
```



#### 2.2.3 通过节点控制从臂（执行重播数据，推理，验证机械臂控制）

**先将主臂的数据线断开，再执行以下指令：**

```shell
roslaunch piper start_ms_piper.launch mode:=1 auto_enable:=true # 启动机械臂节点(控制参数）
```

然后执行

```shell
rostopic list
```

有如下几个topic：

```shell
/arm_status
/enable_flag
/joint_feedback
/master/joint_left
/master/joint_right
/puppet/joint_left
/puppet/joint_right
```



**PS:****可参考第3章进行数据采集，数采完成后，按第3.2.3小节 数据重播，若机械臂运动正常，则机械臂部分检修主流程结束（反馈、控制）。**

## 注意事项

- **执行重播数据，推理，需要先将主臂的数据线断开！！！**
- **在节点参数mode为1，auto_enable为true的情况向话题/master/joint_left或/master/joint_right发布数据，可控制对侧的从臂运动，因为此时相当于工控机代替主臂。**

## 3 数据采集

- 默认ubuntu20.04-noetic环境出厂已经配置完成，**正常情况下3.1节无需安装**。
- 视频教程：

[📎aloha数据采集操作教程.mp4](https://agilexsupport.yuque.com/attachments/yuque/0/2026/mp4/40358905/1774514186172-7a61e3bf-f218-48e8-bc17-1d4c49aee5fa.mp4)

### 3.1 环境依赖

```python
# 1 ros依赖
sudo apt install ros-$ROS_DISTRO-sensor-msgs ros-$ROS_DISTRO-nav-msgs ros-$ROS_DISTRO-cv-bridge

# 2 python依赖
## 2.1 激活python环境
conda activate aloha

## 2.2 安装torch
#  torch==2.1.1
# pip install torch==2.1.1 torchvision==0.16.1 torchaudio==2.1.1 --index-url https://download.pytorch.org/whl/cu118

# torch==1.10.0
pip install torch==1.10.0+cu113 torchvision==0.11.0+cu113 torchaudio==0.10.0 --extra-index-url https://download.pytorch.org/whl/cu113

## 2.3 进入当前工作么空间目录,安装requiredments.txt文件中的依赖即可
cd ~/cobot_magic/collect_data

## 2.4 安装requiredments.txt
pip install -r requirements.txt

## 2.5 安装detr
cd act/detr && pip install -v -e .
```

### 3.2 运行

#### 3.2.1 采集数据

##### 1.硬件检查

- 采集数据前需要保证四条机械臂插好航空插头线，且底座亮起绿灯。

##### 2.. 启动机械臂、相机

- **启动硬件前, 请确保机械臂电源、USB通讯线, 相机USB通讯线成功连接。**
- **如果之前已经启动了机械臂launch文件，采集数据代码就不需要重新启动程序, 只用启动相机launch文件即可。**

```python
# 1 启动硬件
## 1.1 新建一个终端，启动
roscore

# 1.2 进入Piper_ros目录下，激活can模块，并启动机械臂数采launch

cd ~/cobot_magic/Piper_ros_private-ros-noetic/
bash can_config.sh
source devel/setup.bash
roslaunch piper start_ms_piper.launch mode:=0 auto_enable:=false

## 1.3 启动相机
cd ~/cobot_magic/camera_ws
source devel/setup.bash
标准版相机：roslaunch astra_camera multi_camera.launch
realsense相机：roslaunch realsense2_camera multi_camera.launch 
# 1.4 终端运行rostopic list查看ros话题 
rostopic list
# 1.5 一次打印上面ros话题的内容，保证采集数据前, 传感器数据正常
rostopic echo 话题名
## 终端会按频率打印传感器数据, 传感器有数据变化即可
```

 rostopic list如下图所示，若机械臂4个、相机（大白DC1）3个话题消息无误，即可采集数据。

![img](https://cdn.nlark.com/yuque/0/2025/png/33709251/1746587750180-cfa268c5-b6dd-4483-9d55-03b790a145bd.png)



##### 2. 话题说明

数采话题说明如下：

| 话题名                                       | 含义                                               | 单位                                                         |
| -------------------------------------------- | -------------------------------------------------- | ------------------------------------------------------------ |
| /master/joint_left                           | 左侧主臂关节数据                                   | rad                                                          |
| /master/joint_right                          | 右侧主臂关节数据                                   | rad                                                          |
| /puppet/joint_left                           | 左侧从臂关节数据                                   | rad                                                          |
| /puppet/joint_right                          | 右侧从臂关节数据                                   | rad                                                          |
| /puppet/end_pose_left                        | 左侧从臂末端位姿数据（四元数）                     | 平移分量:m，旋转分量:/                                       |
| /puppet/end_pose_right                       | 右侧从臂末端位姿数据（四元数）                     | 平移分量:m，旋转分量:/                                       |
| /puppet/end_pose_euler_left                  | 左侧从臂末端位姿数据（欧拉角）                     | 平移分量:m，旋转分量:rad                                     |
| /puppet/end_pose_euler_right                 | 右侧从臂末端位姿数据（欧拉角）                     | 平移分量:m，旋转分量:rad                                     |
| /puppet/arm_status_left                      | 左侧从臂整体状态反馈                               | /                                                            |
| /puppet/arm_status_right                     | 右侧从臂整体状态反馈                               | /                                                            |
| /camera_f/color/image_raw                    | 顶部摄像头rgb图像                                  | /                                                            |
| /camera_l/color/image_raw                    | 左臂手腕摄像头rgb图像                              | /                                                            |
| /camera_r/color/image_raw                    | 右臂手腕摄像头rgb图像                              | /                                                            |
| /camera_f/aligned_depth_to_color/image_raw   | 顶部摄像头深度图像                                 | /                                                            |
| /camera_l/aligned_depth_to_color/image_raw   | 左臂手腕摄像头深度图像                             | /                                                            |
| /camera_r/aligned_depth_to_color/image_raw   | 右臂手腕摄像头深度图像                             | /                                                            |
| /camera_f/color/camera_info                  | 顶部摄像头rgb内参                                  | /                                                            |
| /camera_l/color/ camera_info                 | 左臂手腕摄像头rgb内参                              | /                                                            |
| /camera_r/color/ camera_info                 | 右臂手腕摄像头rgb内参                              | /                                                            |
| /camera_f/aligned_depth_to_color/camera_info | 顶部摄像头深度内参                                 | /                                                            |
| /camera_l/aligned_depth_to_color/camera_info | 左臂手腕摄像头深度内参                             | /                                                            |
| /camera_r/aligned_depth_to_color/camera_info | 右臂手腕摄像头深度内参                             | /                                                            |
| /odom                                        | 底盘里程计（仅在开启底盘数采情况出现）             | 位移平移分量：m,位移旋转分量：/（四元数）；速度平移分量：m/s，速度旋转分量：rad/s |
| /tracer_states                               | 底盘状态（以tracer为例，仅在开启底盘数采情况出现） | /                                                            |
| /cmd_vel                                     | 底盘控制（仅在开启底盘数采情况出现）               | 速度平移分量：m/s，速度旋转分量：rad/s。                     |



##### 3. 采集数据

```python
# 1 启动roscore
roscore

# 2 激活虚拟环境
conda activate aloha

# 3 启动采集数据
## 3.1 进入~/cobot_magic/collect_data目录
cd ~/cobot_magic/collect_data

## 3.2 查看collect_data.py配置参数
python collect_data.py -h # 查看参数

## 3.3 采集数据
python collect_data.py --dataset_dir ~/data --max_timesteps 500 --episode_idx 0
```

- 数据采集时终端显示如下图所示：

![img](https://cdn.nlark.com/yuque/0/2025/png/33709251/1746588823522-545cf3a2-57f9-4d97-9013-750d9da2d522.png?x-oss-process=image%2Fcrop%2Cx_0%2Cy_0%2Cw_397%2Ch_561)

终端打印`sync fail`是正常的,仅表示**当前时刻**没同步传感器数据, 只要终端不是一直`sync fail`而没有`Frame data:  xxx`输出, 都是正常现象。

只要终端一直有`Frame data:  xxx`打印信息,即表示正在记录数据集。

如果打印`sync fail`,后续没有其他输出, 证明传感器数据没接收到,请按第2章排查相机部分与机械臂部分运行情况。

- 数据保存路径说明

```python
# 数据采集完成后会保存到`${dataset_dir}/${task_name}`目录下
# 运行上面这句代码,其他参数采用默认值。产生数据集episode_0.hdf5,该工程目录如下
collect_data
  ├── collect_data.py
  ├── data                     # --dataset_dir 数据集保存路径
  │   └── aloha_mobile_dummy   # --task_name 任务名
  │       ├── episode_0.hdf5   # 产生数据集文件的位置
          ├── episode_idx.hdf5 # idx由--episode_idx参数决定
          └── ...
  ├── readme.md
  ├── replay_data.py
  ├── requiredments.txt
  └── visualize_episodes.py
```

- collect_data.py参数详细介绍

**ps**:

**1.深度采集参考：****（待更新）**

**2.一批采集数据集中，每条数据的时间长度(max_timesteps参数）需一致才能用act推理**

```python
--dataset_dir       数据集保存路径         
--task_name         任务名,作为数据集的文件名                
--episode_idx       动作分块索引号             
--max_timesteps     最大动作分块的时间步数             
--camera_names      相机名称,默认['cam_high', 'cam_left_wrist', 'cam_right_wrist']  
--img_front_topic   相机1彩色图话题                     
--img_left_topic    相机2彩色图话题                   
--img_right_topic   相机3彩色图话题                   

--use_depth_image   是否使用深度信息   # 已开源   
--depth_front_topic 相机1深度图话题         
--depth_left_topic  相机2深度图话题                    
--depth_right_topic 相机3深度图话题                    

--master_arm_left_topic  左主臂话题
--master_arm_right_topic 右主臂话题                    
--puppet_arm_left_topic  左从臂话题                   
--puppet_arm_right_topic 右从臂话题                   
--use_robot_base         是否使用底盘信息          
--robot_base_topic       底盘话题           
--frame_rate             采集帧率  因相机图像稳定值为30帧,默认30帧    
```

#### 3.2.2 可视化数据集

##### 1.  运行

```python
# 1 激活虚拟环境
conda activate aloha

# 2 进入collect_data文件夹目录下
cd ~/cobot_maigc/collect_data

# 3 运行visualize_episodes.py
python visualize_episodes.py --dataset_dir ~/data --task_name aloha_mobile_dummy 
--episode_idx 0
```

- 运行上述代码可将3.2.1小节采集数据进行可视化。`--dataset_dir`、`--task_name`与`--episode_idx`参数需要与3.2.1小节采集数据时相同。
- 可视化结果如下：
  终端会打印action,并显示一个彩色图像窗口
- ![img](https://cdn.nlark.com/yuque/0/2025/png/33709251/1746517870411-94a12bda-78e8-44cf-833d-7628b32ba8aa.png)
- 运行完成后,会在`${dataset_dir}/{task_name}`下产生`episode_${idx}_qpos.png`、`episode_${idx}_base_action.png`与`episode_${idx}_video.mp4`文件,目录结构如下：

```python
collect_data
├── data
│   ├── aloha_mobile_dummy
│   │   └── episode_0.hdf5
│   ├── episode_0_base_action.png   # base_action图
│   ├── episode_0_qpos.png          # qpos图
│   └── episode_0_video.mp4         # 彩图图视频流
```

- `episode_${idx}_qpos.png`
- ![img](https://cdn.nlark.com/yuque/0/2025/png/33709251/1746517938271-45b5d584-def3-4d8b-954e-f54ebdf87ef7.png)
- `episode_${idx}_base_action.png`
- ![img](https://cdn.nlark.com/yuque/0/2025/png/33709251/1746517983400-5fb3866c-bb02-4b19-992d-d6491ba77b3c.png)



##### 2.  参数说明

- --datset_dir 数据集保存路径
- --task_name 任务名,作为数据集的文件名
- --episode_idx     a动作分块索引号

#### 3.2.3 重播数据集

##### 1. 运行

  **执行这一小节请先运行下述指令关闭所有ROS节点。**

```shell
pkill -f ros
```

- 将采集的数据集包,使用ros发布该数据包的彩色图和机械臂关节姿态。
- 发布该数据包后,cobot_magic可订阅该消息，示教臂根据数据集中的关节数据开始运动。

```python
**需要拔掉主臂的航空插头**
**需要拔掉主臂的航空插头**
**需要拔掉主臂的航空插头**
# 1 启动roscore启动从臂
roslaunch piper start_ms_piper.launch mode:=1 auto_enable:=true

# 2 新启动一个终端，激活虚拟环境
conda activate aloha

# 3 发布彩色图、主臂、从臂消息
## 3.1 进入collect_data目录
cd ~/cobot_magic/collect_data/

## 3.2 重播数据集，从臂重复执行录得数据
python replay_data.py --dataset_dir ~/data --task_name aloha_mobile_dummy --episode_idx 0

# 4 发布彩色图、从臂消息
python replay_data.py --dataset_dir ~/data --task_name aloha_mobile_dummy 
--only_pub_master --episode_idx 0
```

##### 2.  参数说明

- --dataset_dir     数据集保存路径
- --task_name       任务名,作为数据集的文件名
- --episode_idx     动作分块索引号  
- --only_pub_puppet 是否只发布主臂的关节姿态消息

## 4 ACT训练推理

### 4.1 环境配置

- ubuntu-20.04,cuda-11.8,cudnn-8.6.0,torch-2.1.1, python-3.8已测试通过
- ubuntu-20.04,cuda-11.3,cudnn-8.6.0,torch-1.10.0,python-3.8已测试通过
- 出厂已经配置好推理环境，无需重复配置，正常使用请调过该节。

```python
# 1 创建conda虚拟环境
conda create -n aloha python=3.8

# 2 激活虚拟环境
conda activate aloha

# 3 安装torch==1.10.0
pip install torch==1.10.0+cu113 torchvision==0.11.0+cu113 torchaudio==0.10.0 --extra-index-url https://download.pytorch.org/whl/cu113

# 4 安装requrements.txt
pip install -r requrements.txt

# 5 安装detr
cd aloha-devel/act/detr && pip install -v -e .
```

详情请参考[mobile-aloha](https://github.com/MarkFzp/mobile-aloha) 、[act-plus-plus](https://github.com/MarkFzp/act-plus-plus)

### 4.2 数据集采集

- 参考本文3.2.1(采集数据)小结。

### 4.3 训练

```python
# 1 激活虚拟环境
conda activate aloha

# 2 训练
## 2.1 进入aloha-devel目录
cd ~/cobot_maigc/aloha-devel

## 2.2 启动训练
python act/train.py --dataset_dir ~/data --ckpt_dir train --batch_size 4 --num_epochs 5000 --num_episodes 50
```

1. 主要参数参数说明 目前仅支持ACT模型训练

- --dataset_dir     数据集目录
- --ckpt_dir    训练模型保存目录
- --batch_size  训练批量大小
- --num_epochs  训练周期
- --task_name   任务名称
- --pretrain_ckpt 预训练模型路径
- --ckpt_name   模型名称
- --num_episodes 数据组数

### 4.4 推理

```python
# 1 新启动一个终端，启动从臂与相机
## 1.1 进入Piper_ros目录
cd cobot_magic/Piper_ros_private-ros-noetic/
source devel/setup.bash

## 1.2 启动2条从臂,启动前需要将机械臂断电重启
**需要拔掉主臂的航空插头**
**需要拔掉主臂的航空插头**
**需要拔掉主臂的航空插头**
roslaunch piper start_ms_piper.launch mode:=1 auto_enable:=true

# 2 推理
## 2.1 激活虚拟环境
conda activate aloha

## 2.2 执行推理
## 2.2.1 进入aloha-devel目录
cd ~/cobot_magic/aloha-devel
## 2.2.2 推理
python act/inference.py --ckpt_dir train
## 推理时注意安全, 如果发现推理表现不正常, 请立即中断代码或断开机械臂电源，以免损伤机械臂
```



## 5 Q&A



Q: 遥操作时,由于暴力操作或者误操作导致某条机械臂限位，无法正常工作。

A: 正常的臂归零位状态, 无法正常运作的臂用手托着，然后关闭机械臂所有终端或者断电，重新启动即可



Q: 启动底盘后, 有里程计/odom消息, 但是移动车,/odom数据始终处于0数据。

A: 底盘can使能, 然后重新启动底盘程序



Q：如何查看ros话题频率

A: 终端输入`rostopic hz 话题名称`即可打印该话题频率



Q: 运行collect_data.py脚本，如果代码报错

A: 请使用cobot_magic自带的镜像环境



Q: 运行collect_data.py脚本，如果终端一直打印`sync fail`

A: 请检查collect_data.py收集的ros话题是否有正常输出, 没有正常输出请检查各**话题名**是否对应



Q：终端报错信息如下：

```python
RLException: roscore cannot run as another roscore/master is already running. 
Please kill other roscore/master processes before relaunching.
The ROS_MASTER_URI is http://PC:11311/
The traceback for the exception was written to the log file
```

A: 由于重复启动roscore导致, 可以重启或者注销电脑



Q: 底盘ros里程计消息`/odom`打印,数字没有变化

A: 确定底盘`can2usb`线是否成功连接和底盘`can`是否使能



Q：训练时终端报错信息如下：

```python
Cannot move to target thread (0x555c3308b1b0) qt.qpa.plugin: Could not load the Qt platform plugin "xcb" in "/home/agilex/miniconda3/envs/aloha/lib/python3.8/site-packages/cv2/qt/plugins" even though it was found. This application failed to start because no Qt platform plugin could be initialized. Reinstalling the application may fix this problem. Available platform plugins are: xcb, eglfs, linuxfb, minimal, minimalegl, offscreen, vnc, wayland-egl, wayland, wayland-xcomposite-egl, wayland-xcomposite-glx, webgl.
```

A: 训练代码用到了 OpenCV(cv2)，它默认依赖 Qt 图形界面；但服务器 / 无桌面环境无法加载图形插件，直接导致程序崩溃。

在运行训练脚本的终端里，先执行这两行命令，再启动训练。

```python
# 强制Qt使用离线渲染，禁用图形界面
export QT_QPA_PLATFORM=offscreen
# 屏蔽OpenCV无关日志
export OPENCV_LOG_LEVEL=ERROR
```