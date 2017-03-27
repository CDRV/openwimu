//#include "wimu_util.h"
//
//static void WIMU_packetInitRand(uint16 seq, WIMU_packet_t* packet){
//
//  packet->seq = seq;
//  
//  packet->acc.x = osal_rand();
//  packet->acc.y = osal_rand();
//  packet->acc.z = osal_rand();
//
//  packet->gyr.x = osal_rand();
//  packet->gyr.y = osal_rand();
//  packet->gyr.z = osal_rand();
//
//  packet->mag.x = osal_rand();
//  packet->mag.y = osal_rand();
//  packet->mag.z = osal_rand();
//}
//  
//static void WIMU_packetInitZero(uint16 seq, WIMU_packet_t* packet){
//  return;
//}