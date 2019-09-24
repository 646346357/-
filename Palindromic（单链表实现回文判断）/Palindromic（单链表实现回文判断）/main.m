//
//  main.m
//  Palindromic（单链表实现回文判断）
//
//  Created by 覃稳 on 2019/9/17.
//  Copyright © 2019年 覃稳. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef struct LinkedList {
    char c;
    struct LinkedList *next;
} LinkedList;

//创建回文测试单链表
LinkedList* createPalindromicTestData() {
    char string[] = {'a', 'd', 'c', 'b', 'a'};
    int count = sizeof(string)/sizeof(char);
    LinkedList *list = (LinkedList *)malloc(sizeof(LinkedList));
    list->next = NULL;
    while (count--) {
        LinkedList *p = (LinkedList *)malloc(sizeof(LinkedList));
        p->c = string[count];
        p->next = list->next;
        list->next = p;
    }
    
    return list->next;
}

//打印单链表
void printLinkedList(LinkedList *list) {
    LinkedList *l = list;
    while (l) {
        printf("%c ", l->c);
        l = l->next;
    }
}

#pragma mak - 单链表实现回文判断
bool palindromicJudge(LinkedList *list) {
    LinkedList *slow = list;
    LinkedList *quick = list;
    LinkedList *pre = NULL;
    if (!list) {
        return false;
    }
    if (!list->next) {
        return true;
    }
    
    while (quick && quick->next) {
        quick = quick->next->next;
        LinkedList *next = slow->next;
        slow->next = pre;
        pre = slow;
        slow = next;
        if (quick && !quick->next) {//长度为奇数
            slow = slow->next;
        }
    }
    
    while (slow) {
        if (pre->c != slow->c) {
            return false;
        }
        slow = slow->next;
        pre = pre->next;
    }
    
    return true;
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        LinkedList *l = createPalindromicTestData();
        printLinkedList(l);
        printf(palindromicJudge(l) ? "是回文字符串\n" : "不是回文字符串\n") ;
    }
    return 0;
}
