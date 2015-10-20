__author__ = 'wangguojin'
import Image
import os
filePath = "BlendTest/"
addrSets = ['.png','.jpg','.jpeg']

def loadImageInDir():
    values = []
    files = os.listdir(filePath)
    if len(files) > 0:
        for name in files:
            item = filePath + name
            addr = name[name.rfind('.'):]
            if os.path.isfile(item) and addr in addrSets:
                values.append(name)
    return values

def scaleImageInAll(img,rsize):
    return img.resize(rsize)

def run():
    files = loadImageInDir()
    blendImg = None
    if len(files) > 0:
        imsize = None
        idx = 0
        for item in files:
            img = Image.open(filePath + item)
            if imsize == None:
                imsize = [img.size[0], img.size[1]]
            # 1 scale to same size
            if imsize[0] != img.size[0] or imsize[0] != img.size[1]:
                img = scaleImageInAll(img,imsize)
            # 2 convert to gray
            if img.mode != "L":
                gray = img.convert("L")
            if blendImg == None:
                blendImg = Image.new("RGBA",imsize)
            if idx == 3:
                blendImg.putalpha(gray)
            else:
                blendImg.im.putband(gray.im,idx)
            idx = idx + 1
        blendImg.save(filePath + "blend.tga",)
        blendImg.show()
    else:
        print 'no images in dir'

print "start to progress"
run()
print "end progress"