//
//  TreeMap.swift
//  TreeMap
//
//  Created by Aaron Vinh on 2/7/17.
//  Copyright © 2017 Aaron Vinh. All rights reserved.
//

import Foundation


class TreeMap{
    
    var stack: [[Double]]
    
    init(){
       stack = [[Double]]()
    }
    
    /*normalizes data so we get areas proportianal to the each data point size
      that also all fit in the given area of the container box
    */
    func normalize(data: [Double], area: Double) -> [Double] {
        var normalizedData = [Double]()
        let sum  = data.reduce(0,+)
        let multiplier = area/sum
        for i in 0...(data.count-1){
            normalizedData.append(data[i] * multiplier)
        }
        print("normalizedData \(normalizedData)")
        return normalizedData
    }
    
    /*wrapper for squarify, takes in data, width/length and offsets of container
      and returns coordinates of each inner box
    */
    func treemapCoords(data: [Double], width: Double, height: Double, xOffset: Double, yOffset: Double)->[[Double]]{
        let newData = normalize(data:data,area: width*height)
        let container = Container(xOff: xOffset,yOff: yOffset,h: height,w: width)
        let rawTreemap = squarify(d: newData,cRow: [], container: container)
        
        print("TreeMap \(flattenTreemap(rawTreemap:rawTreemap))")
       // return flattenTreemap(rawTreemap:rawTreemap)
        return rawTreemap
    }
    
    
    func flattenTreemap(rawTreemap: [[Double]])->[[Double]]{
        var flatTreeMap = [[Double]]()
        print("raw treemap \(rawTreemap)")
        for  (i,_) in rawTreemap.enumerated(){
            for (j,_) in rawTreemap[i].enumerated(){
                flatTreeMap.append([rawTreemap[i][j]])
            }
        }
        print("flattenTreemap \(flatTreeMap)")
        return flatTreeMap
    }
    
    /*follows Brul's paper to make splice container into smaller boxes based 
      on the size of each data point
    */
    func squarify(d: [Double], cRow: [Double], container: Container)->[[Double]]{
        var data = d
        var currentRow = cRow
        print( "squarify \(stack)")
        if (data.count == 0 ){
            print("squarify in if count = 0 \(container.getCoordinates(row:currentRow))")
            stack += container.getCoordinates(row:currentRow)
            print("stack after append \(stack)")
            return stack
        }
        
        let length = container.shortestEdge()
        let nextDataPoint = data[0]
        
        if(improvesRatio(currentRow:currentRow,nextNode:nextDataPoint,length:length)){
            currentRow.append(nextDataPoint)
            data.remove(at: 0)
            squarify(d: data,cRow: currentRow,container: container)
        }
        else{
            let newContainer = container.cutArea(area: currentRow.reduce(0,+))
            print("stack before append else \(stack)")
            stack += (container.getCoordinates(row:currentRow))
            print("stack after append else \(stack)")

            squarify(d: data,cRow: [],container: newContainer)
        }
        
        return stack
        
    }
    
    /* Calculates if adding the nextNode to the row improves or worsens the ratio
      of the row (ratio improves if it is closer to 1:1 between height and width)
    */
    func improvesRatio(currentRow: [Double], nextNode: Double, length: Double)->Bool{
        
        if (currentRow.count == 0 ){
            return true
        }
        
        var newRow = currentRow
        newRow.append(nextNode)
        
        let currentRatio = calculateRatio(row:currentRow,length: length)
        let newRatio = calculateRatio (row:newRow,length:length)
        
        return currentRatio >= newRatio
    }
    
    //Calculates the maximum width to height ratio for the boxes in the row
    func calculateRatio(row: [Double], length: Double)->Double{
        if let minimum = row.min(),  let maximum = row.max(){
            let sum  = row.reduce(0,+)
            let ratio1 = length * length * maximum / (sum * sum)
            let ratio2 = sum * sum / (length * length * minimum)
            print ("ratio \(max(ratio1,ratio1))")
            return max(ratio1,ratio2)
        }
        print ("NOT CALCULATE")
         return 0
        
        
    }
}
