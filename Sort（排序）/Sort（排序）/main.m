//
//  main.m
//  Sort（排序）
//
//  Created by 覃稳 on 2019/9/19.
//  Copyright © 2019年 覃稳. All rights reserved.
//

#import <Foundation/Foundation.h>

void mergeSortRecursive(int *list, int start, int end);
void merge(int *list, int start1, int end1, int start2, int end2);
void quickSortRecursive(int *list, int start, int end);
int partition(int *list, int start, int end, int pivot);
void swapArray(int *list, int i, int j);
void printArray(int *list, int n);
void printSortArray(int *list, int n, bool isAscending);
void copyArray(int *srcList, int *targetList, int n);

#pragma mark - 冒泡排序
void bubbleSort(int* list, int n){
    if (n <= 1) {
        return;
    }
    
    for (int i = 0; i < n; i++) {
        bool exchangeFlag = false;
        for (int j = 0; j < n-i-1; j++) {
            if (list[j] > list[j+1]) {
                int tmp = list[j];
                list[j] = list[j+1];
                list[j+1] = tmp;
                exchangeFlag = true;
            }
        }
        if(!exchangeFlag){//对排序算法进行优化，如果没有元素需要交换，说明已经全部排好序了，结束循环
            break;
        }
    }
}

#pragma mark - 插入排序
void insertionSort(int *list, int n) {
    if (n <= 1) {
        return;
    }
    
    for (int i = 1; i < n; i++) {
        int value = list[i];
        int j = i-1;
        for (; j >= 0; j--) {
            if (value < list[j]) {
                list[j+1] = list[j];
            } else {
                break;
            }
        }
        list[j+1] = value;
    }
}

#pragma mark - 选择排序
void selectionSort(int *list, int n){
    if (n <= 1) {
        return;
    }
    
    for (int i = 0; i < n; i++) {
        int j = i;
        int minIndex = j;
        for (; j < n; j++) {
            if (list[minIndex] > list[j]) {
                minIndex = j;
            }
        }
        int minValue = list[minIndex];
        list[minIndex] = list[i];
        list[i] = minValue;
    }
}

#pragma mark - 归并排序
void mergeSort(int *list, int n) {
    if (n <= 1) {
        return;
    }
    
    mergeSortRecursive(list, 0, n-1);
}

void mergeSortRecursive(int *list, int start, int end) {
    if (start >= end) {
        return;
    }
    
    //按分治思想，分为左右两部分
    int middle = (start + end) / 2;
    mergeSortRecursive(list, start, middle);
    mergeSortRecursive(list, middle+1, end);
    //对已排序的数组进行合并
    merge(list, start, middle, middle+1, end);
}

void merge(int *list, int start1, int end1, int start2, int end2){
    int left = start1;
    int right = start2;
    int k = 0;
    int *tmp = (int *)malloc(sizeof(*list)*((end1-start1+1)+(end2-start2+1)));
    while (left <= end1 && right <= end2) {
        if (list[left] <= list[right]) {
            tmp[k] = list[left];
            left++;
        } else {
            tmp[k] = list[right];
            right++;
        }
        k++;
    }
    
    while (left <= end1) {
        tmp[k] = list[left];
        left++;
        k++;
    }
    
    while (right <= end2) {
        tmp[k] = list[right];
        right++;
        k++;
    }
    
    for (int i = start1; i <= end2; i++) {
        list[i] = tmp[i-start1];
    }
}

#pragma mark - 快速排序
void quickSort(int *list, int n){
    if (n <= 1) {
        return;
    }
    
    quickSortRecursive(list, 0, n-1);
}

void quickSortRecursive(int *list, int start, int end){
    if (start >= end) {
        return;
    }
    
    int q = partition(list, start, end, end);
    quickSortRecursive(list, start, q-1);
    quickSortRecursive(list, q+1, end);
}

int partition(int *list, int start, int end, int pivot){
    int i = start;
    for (int j = start; j <= end; j++) {
        if (list[j] < list[pivot]) {
            swapArray(list, i, j);
            i++;
        }
    }
    swapArray(list, i, pivot);
    
    return i;
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

//打印数组并判断排序是否正确
void printSortArray(int *list, int n, bool isAscending) {
    bool sorted = true;
    for (int i = 0; i < n; i++) {
        printf("%d ", *(list+i));
        if (i > 0) {
            if ((isAscending && list[i] < list[i-1]) || (!isAscending && list[i] > list[i-1])) {
                sorted = false;
            }
        }
    }
    printf("%s \n", sorted ? "✔️" : "❌");
}

//拷贝数组
void copyArray(int *srcList, int *targetList, int n) {
    for (int i = 0; i < n; i++) {
        targetList[i] = srcList[i];
    }
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        int constArray[] = {9,3,7,5,1,6,2,3,6,1,4};
        int n = sizeof(constArray)/sizeof(int);
        printf("冒泡排序\n");
        int *list = (int *)malloc(sizeof(constArray));
        copyArray(constArray, list, n);
        printf("排序前：");
        printArray(list, n);
        bubbleSort(list, n);
        printf("排序后：");
        printSortArray(list, n, true);
        
        printf("\n\n");
        printf("插入排序\n");
        list = (int *)malloc(sizeof(constArray));
        copyArray(constArray, list, n);
        printf("排序前：");
        printArray(list, n);
        insertionSort(list, n);
        printf("排序后：");
        printSortArray(list, n, true);
        
        printf("\n\n");
        printf("选择排序\n");
        list = (int *)malloc(sizeof(constArray));
        copyArray(constArray, list, n);
        printf("排序前：");
        printArray(list, n);
        selectionSort(list, n);
        printf("排序后：");
        printSortArray(list, n, true);
        
        printf("\n\n");
        printf("归并排序\n");
        list = (int *)malloc(sizeof(constArray));
        copyArray(constArray, list, n);
        printf("排序前：");
        printArray(list, n);
        mergeSort(list, n);
        printf("排序后：");
        printSortArray(list, n, true);
        
        printf("\n\n");
        printf("快速排序\n");
        list = (int *)malloc(sizeof(constArray));
        copyArray(constArray, list, n);
        printf("排序前：");
        printArray(list, n);
        quickSort(list, n);
        printf("排序后：");
        printSortArray(list, n, true);
    }
    return 0;
}
