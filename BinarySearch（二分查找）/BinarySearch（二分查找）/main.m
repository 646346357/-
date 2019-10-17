//
//  main.m
//  BinarySearch（二分查找）
//
//  Created by 覃稳 on 2019/10/17.
//  Copyright © 2019 te. All rights reserved.
//

#import <Foundation/Foundation.h>

void swapArray(int *list, int i, int j);
void printArray(int *list, int n);
void copyArray(int *srcList, int *targetList, int n);

#pragma mark - 简单二分查找

int simpleBinarySearch(int *list, int n, int value){
    int low = 0;
    int high = n-1;
    while (high >= low) {
        int mid = low + ((high-low) >> 1);
        if (value == list[mid]) {
            return mid;
        } else if (value < list[mid]) {
            high = mid - 1;
        } else {
            low = mid + 1;
        }
    }
    
    return -1;
}


#pragma mark - 二分查找(查找某个数第一次出现的位置)

int binarySearchFirstValue(int *list, int n, int value){
    int low = 0;
    int high = n-1;
    while (high >= low) {
        int mid = low + ((high-low) >> 1);
        if (value < list[mid]) {
            high = mid - 1;
        } else if (value > list[mid]){
            low = mid + 1;
        } else {
            if (0 == mid || list[mid-1] != value) {
                return mid;
            } else {
                high = mid - 1;
            }
        }
    }
    
    return -1;
}

#pragma mark - 二分查找(查找某个数最后一次出现的位置)

int binarySearchLastValue(int *list, int n, int value){
    int low = 0;
    int high = n-1;
    while (high >= low) {
        int mid = low + ((high-low) >> 1);
        if (value < list[mid]) {
            high = mid - 1;
        } else if (value > list[mid]){
            low = mid + 1;
        } else {
            if (n-1 == mid || list[mid+1] != value) {
                return mid;
            } else {
                low = mid + 1;
            }
        }
    }
    
    return -1;
}

#pragma mark - 二分查找(查找第一个大于等于某个值的数出现的位置)

int binarySearchFirstGreaterOrEqualValue(int *list, int n, int value){
    int low = 0;
    int high = n-1;
    while (high >= low) {
        int mid = low + ((high-low) >> 1);
        if (value > list[mid]){
            low = mid + 1;
        } else {
            if (mid == 0 || list[mid-1] < value) {
                return mid;
            } else {
                high = mid - 1;
            }
        }
    }
    
    return -1;
}

#pragma mark - 二分查找(查找最后一个小于等于某个值的数出现的位置)

int binarySearchLastLessOrEqualValue(int *list, int n, int value){
    int low = 0;
    int high = n-1;
    while (high >= low) {
        int mid = low + ((high-low) >> 1);
        if (value < list[mid]){
            high = mid - 1;
        } else {
            if (mid == n-1 || list[mid+1] > value) {
                return mid;
            } else {
                low = mid + 1;
            }
        }
    }
    
    return -1;
}

#pragma mark - 工具函数
//交换数组元素位置
void swapArray(int *list, int i, int j) {
    int tmp = list[j];
    list[j] = list[i];
    list[i] = tmp;
}

//打印数组
void printArray(int *list, int n){
    for (int i = 0; i < n; i++) {
        printf("%d ", *(list+i));
    }
    printf("\n");
}

//拷贝数组
void copyArray(int *srcList, int *targetList, int n) {
    for (int i = 0; i < n; i++) {
        targetList[i] = srcList[i];
    }
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        int constArray[] = {1, 2, 3, 5, 6, 7};
        int n = sizeof(constArray)/sizeof(int);
        int *list = (int *)malloc(sizeof(constArray));
        int value = 5;
        copyArray(constArray, list, n);
        int index = simpleBinarySearch(list, n, value);
        printf("简单二分查找，%d在数组中的位置是%d(%s)\n\n", value, index, index == -1 ? "没找到" : "找到了");
        
        int constArray2[] = {1, 2, 3, 3, 3, 3, 5, 6, 7};
        int n2 = sizeof(constArray2)/sizeof(int);
        value = 3;
        index = binarySearchFirstValue(constArray2, n2, value);
        printf("二分查找，%d在数组中第一次出现的位置是%d(%s！)\n\n", value, index, index == -1 ? "没找到" : "找到了");
        
        index = binarySearchLastValue(constArray2, n2, value);
        printf("二分查找，%d在数组中最后一次出现的位置是%d(%s！)\n\n", value, index, index == -1 ? "没找到" : "找到了");
        
        value = 6;
        index = binarySearchFirstGreaterOrEqualValue(constArray2, n2, value);
        printf("二分查找，在数组中第一个大于等于%d的数出现的位置是%d(%s！)\n\n", value, index, index == -1 ? "没找到" : "找到了");
        
        value = 3;
        index = binarySearchLastLessOrEqualValue(constArray2, n2, value);
        printf("二分查找，在数组中最后一个小于等于%d的数出现的位置是%d(%s！)\n\n", value, index, index == -1 ? "没找到" : "找到了");
       
    }
    return 0;
}
