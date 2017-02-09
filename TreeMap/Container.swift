//
//  Container.swift
//  TreeMap
//
//  Created by Aaron Vinh on 2/7/17.
//  Copyright © 2017 Aaron Vinh. All rights reserved.
//  Based heavily on https://github.com/imranghory/treemap-squared javascript
//  implementation of Treemap

import Foundation

class Container{
    
    var xOffset:Double //offset from left side
    var yOffset:Double //offset from top side
    var height:Double
    var width:Double
    
    init (xOff:Double,yOff:Double,h:Double,w:Double){
        self.xOffset = xOff
        self.yOffset = yOff
        self.height = h
        self.width = w
        
    }
    
    //returns the shortest edge on the container
    func shortestEdge()->Double {
        print("shortestEdge \(min(height,width))")
        return min(height,width)
    }
    
    //for a row of boxes which have been placed return an array of their cartesian coordinates
    func getCoordinates(row: [Double])-> [[Double]]{
        var coordinates = [[Double]]()
        var subXOffset = self.xOffset //xOffset within container
        var subYOfsset = self.yOffset //yOffset within container
        let areaWidth = row.reduce(0,+) / self.height
        let areaHeight = row.reduce(0,+) / self.width
        
        if (self.width >= self.height){
            for i in 0...row.count-1{
                coordinates.append([subXOffset,subYOfsset,subXOffset+areaWidth,subYOfsset+row[i]/areaWidth])
                subYOfsset = subYOfsset + row[i] / areaWidth
            }
        }
        else{
            for i in 0...row.count-1{
                coordinates.append([subXOffset,subYOfsset,subXOffset + row[i]/areaHeight,subYOfsset+areaHeight])
                subXOffset = subXOffset + row[i] / areaHeight
            }
        }
        print("getCoordinates \(coordinates)")
        return coordinates
    }
    
    /*calculate remaining area after placing boxes in a row. takes combined area
      of boxes placed and calculates dimensions and offset of remaining space 
      and returns a container box defined by the remaining area
    */
    
    func cutArea(area: Double)->Container{
        if (self.width >= self.height){
            let areaWidth = area / self.height
            let newWidth = self.width - areaWidth
            let newContainer = Container(xOff: self.xOffset+areaWidth,yOff: self.yOffset,h: self.height,w: newWidth)
            print("cutArea \(newContainer)")
            return newContainer
        }
        else{
            let areaHeight = area / self.width
            let newHeight  = self.height - areaHeight
            let newContainer = Container(xOff: self.xOffset,yOff: self.yOffset + areaHeight, h: newHeight, w: self.width
            )
            print("cutArea \(newContainer)")
            return newContainer
        }
    }
    
}
