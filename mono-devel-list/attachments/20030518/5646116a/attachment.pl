*** mono/io-layer/threads.c.orig	Fri May 16 14:16:23 2003
--- mono/io-layer/threads.c	Fri May 16 14:19:30 2003
***************
*** 189,194 ****
--- 189,195 ----
  {
  	struct _WapiHandle_thread *thread_handle;
  	struct _WapiHandlePrivate_thread *thread_private_handle;
+ 	pthread_attr_t attr;
  	gpointer handle;
  	gboolean ok;
  	int ret;
***************
*** 231,237 ****
  	 */
  	mono_mutex_lock(&thread_hash_mutex);
  	
! 	ret=_wapi_timed_thread_create(&thread_private_handle->thread, NULL,
  				      create, start, thread_exit, param,
  				      handle);
  	if(ret!=0) {
--- 232,241 ----
  	 */
  	mono_mutex_lock(&thread_hash_mutex);
  	
! 	pthread_attr_init(&attr);
! 	pthread_attr_setstacksize(&attr, 2093056);
! 	
! 	ret=_wapi_timed_thread_create(&thread_private_handle->thread, &attr,
  				      create, start, thread_exit, param,
  				      handle);
  	if(ret!=0) {

