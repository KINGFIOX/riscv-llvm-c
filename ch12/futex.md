One use of futexes is for implementing locks.  The state of the lock (i.e., acquired or not acquired) can be represented as an atomically accessed flag in shared memory.  In the uncontended case, a thread can access or modify the lock state with atomic instructions, for example atomically changing it from not acquired to acquired using an atomic compare-and-exchange instruction.  (Such instructions are performed entirely in user mode, and the kernel maintains no information about the lock state.)  On the other hand, a thread may be unable to acquire a lock because it is already acquired by another thread.  It then may pass the lock's flag as a futex word and the value representing the acquired state as the expected value to a futex() wait operation.  This futex() operation will block if and only if the lock is still acquired (i.e., the value in the futex word still matches the "acquired state"). When releasing the lock, a thread has to first reset the lock state to not acquired and then execute a futex operation that wakes threads blocked on the lock flag used as a futex word (this can be further optimized to avoid unnecessary wake-ups).  See futex(7) for more detail on how to use futexes.

Note that no explicit initialization or destruction is necessary to use futexes; the kernel maintains a futex (i.e., the kernel-internal implementation artifact) only while operations such as FUTEX_WAIT, described below, are being performed on a particular futex word.

 The purpose of the comparison with the expected value is to prevent lost wake-ups.  If another thread changed the value of the futex word after the calling thread decided to block based on the prior value, and if the other thread executed a FUTEX_WAKE operation (or similar wake-up) after the value change and before this FUTEX_WAIT operation, then the calling thread will observe the value change and will not start to sleep.

 This operation is like FUTEX_WAIT except that val3 is used to provide a 32-bit bit mask to the kernel.  This bit mask, in which at least one bit must be set, is stored in the kernel- internal state of the waiter.  See the description of FUTEX_WAKE_BITSET for further details.

If timeout is not NULL, the structure it points to specifies an absolute timeout for the wait operation.  If timeout is NULL, the operation can block indefinitely.

              The uaddr2 argument is ignored.

Priority inheritance is a mechanism for dealing with the priority- inversion problem.  With this mechanism, when a high-priority task becomes blocked by a lock held by a low-priority task, the priority of the low-priority task is temporarily raised to that of the high- priority task, so that it is not preempted by any intermediate level tasks, and can thus make progress toward releasing the lock.  To be effective, priority inheritance must be transitive, meaning that if a high-priority task blocks on a lock held by a lower-priority task that is itself blocked by a lock held by another intermediate-priority task (and so on, for chains of arbitrary length), then both of those tasks (or more generally, all of the tasks in a lock chain) have their priorities raised to be the same as the high-priority task.

       From a user-space perspective, what makes a futex PI-aware is a policy agreement (described below) between user space and the kernel about the value of the futex word, coupled with the use of the PI-futex operations described below.  (Unlike the other futex operations described above, the PI-futex operations are designed for the implementation of very specific IPC mechanisms.)




