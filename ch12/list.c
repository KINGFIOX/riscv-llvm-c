#include <stdio.h>
#include <stdlib.h>

// 定义链表节点结构体
typedef struct ListNode {
  int data;              // 数据域
  struct ListNode *next; // 指向下一个节点的指针
} ListNode;

// 定义链表结构体，这里我们的链表包含一个头结点
typedef struct LinkedList {
  ListNode *head; // 指向头结点的指针
} LinkedList;

// 创建链表，初始化头结点
LinkedList *createLinkedList() {
  LinkedList *list = (LinkedList *)malloc(sizeof(LinkedList));
  if (list) {
    list->head = (ListNode *)malloc(sizeof(ListNode)); // 创建头结点
    if (list->head) {
      list->head->next = NULL; // 头结点的next指向NULL
    } else {
      free(list); // 如果头结点创建失败，释放链表结构体所占内存
      return NULL;
    }
  }
  return list;
}

// 在链表尾部插入节点
void insertNode(LinkedList *list, int data) {
  ListNode *newNode = (ListNode *)malloc(sizeof(ListNode));
  newNode->data = data;
  newNode->next = NULL;

  // 找到链表的最后一个节点
  ListNode *current = list->head;
  while (current->next != NULL) {
    current = current->next;
  }
  // 将新节点插入到链表尾部
  current->next = newNode;
}

// 删除链表中的节点
void deleteNode(LinkedList *list, int data) {
  ListNode *current = list->head;
  ListNode *previous = NULL;
  while (current->next != NULL && current->next->data != data) {
    previous = current;
    current = current->next;
  }
  if (current->next != NULL) {
    ListNode *temp = current->next;
    current->next = current->next->next;
    free(temp);
  }
}

// 查找链表中的节点
ListNode *findNode(LinkedList *list, int data) {
  ListNode *current = list->head->next; // 从第一个实际存储数据的节点开始
  while (current != NULL && current->data != data) {
    current = current->next;
  }
  return current;
}

// 销毁链表
void destroyLinkedList(LinkedList *list) {
  ListNode *current = list->head;
  while (current != NULL) {
    ListNode *temp = current;
    current = current->next;
    free(temp);
  }
  free(list);
}
