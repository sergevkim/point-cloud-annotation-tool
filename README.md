# [Point Cloud Annotation Tool](https://github.com/Louisgcr/point-cloud-annotation-tool)

Branch | Status
------------ | -------------
Master |[![CircleCI](https://circleci.com/gh/Louisgcr/point-cloud-annotation-tool/tree/master.svg?style=svg)](https://circleci.com/gh/Louisgcr/point-cloud-annotation-tool/tree/master)

##  point cloud annotation tool
It is a tool used to annotate 3D box in point cloud. Point cloud in KITTI-bin format is supported. Annotation format is the same as Applo 3D format. Data examples can be found at [here](http://data.apollo.auto/help?name=data_intro_3d&data_key=lidar_obstacle_label&data_type=0&locale=en-us&lang=en).

## Tutorial from @sergevkim:

__ВНИМАНИЕ!!!__ Необходимо выделить 30 (тридцать) GB под Docker образ

Чтобы собрать запустить контейнер:
- Перейти в папку `point-cloud-annotation-tool/docker`
- `./build.sh <name>`
- `./run.sh <name> <port-id>`

Внутри контейнера сам инструмент будет лежать в ~/pcat/build/point_cloud_annotation_tool

Допустим, мы запустили инструмент. Интерфейс его довольно незамысловат:

- Открыть point cloud: нажать на __Open__ (или __File__, __Open__) в Menubar. Обращаю внимание, что открыть .ply файл нельзя (но .pcd можно). .py скрипт для конвертации .ply в .pcd лежит в point-cloud-annotation-tool/pcd2ply.py. Внутри контейнера он находится в ~/pcat/pcd2ply.py. Пример использования:

`python pcd2ply.py --ply_path=arena.ply --pcd_path=arena.pcd`

- Нажать __X__ - перейти в режим __разметки__/выйти из него (по умолчанию режим __НЕ разметки__). В режиме __разметки__ можно размечать коробки таким образом: сначала мышкой выбрать 2d область (все точки области покраятся цветом), затем выбрать _label_ в списке __Types__, и коробка отрисуется сразу. Можно будет поменять размеры коробы, а также крутить её вдоль оси z.
- Сохранить данные о коробах point cloud-a: нажать на __File__, __Save__ в Menubar. Результат сохранится в "<pcd_path>.txt". В этом файле лежат только описания короб в следующем формате:

label x y z length width height yaw, где плоскость пола - xy

(desk 5.131035 0.391286 -2.334609 16.185757 14.443742 23.234538 0.000000)

![example1 image](example_new.png)

![Demo](pcl_demo.gif)

### supported functions
- load, save, visiualize
- point cloud selection
- 3d box generation
- ground remove using threhold or plane detect

### New Features
- 3 Additional camera view (top, front, side) that snaps to object
- Ability to move box object in any render window
- Added a full screen feature to toggle current render window and normal view
- Real time update of box details in message box below
- Points in boxs are highlighted green
- Box Opacity reduce to see through box 
- Lowered point intensity to see clearer

### usage
- if *cloud.bin* is open, then *cloud.bin.txt* will be the annotation file to be loaded if exist.
- click to select an annotaion, then edit it, rotate it or just press 'Del' to delete.
- 'x' to toggle selection mode,then left click with ctrl or shift to help select.
- click label button to annotate a 3D box.

### additional usage
- ctrl + z to toggle full screen and selected render window


### dependency
Tested with pcl 1.8, vtk 8.1, Qt5  under both ubuntu 16.04 and windows 10.
to build:
```
mkdir build && cd build && cmake .. && make
```

## Authors
1. Louis Goh 
2. springzfx- Initial Work

##  Acknowledgement
1. Fancy Zhang

(Meow!!)  
.....\  
........_  
.....<(o )___  
......( .__> /  
........`-----'  

## License
[MIT](https://github.com/nishanths/license/blob/master/LICENSE)



