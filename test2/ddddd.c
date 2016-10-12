#include <stdio.h>
#include <pcap.h>
#include <stdlib.h>
#include <time.h>
int main(void)
{	
	char errBuf[PCAP_ERRBUF_SIZE] , * device;
	printf("%d\n", PCAP_ERRBUF_SIZE);
	//char * pcap_lookupdev(char * errBuf)
	device = pcap_lookupdev(errBuf);

	if (device)
	{
		printf("%s\n",device);
	}
	else
	{
		printf("%s\n", errBuf);
		exit(1);
	}
	pcap_t * dev = pcap_open_live(device,65535,1,5000,errBuf);
	//pcap_t * pcap_open_live(const char * device ,int snaplen,int promisc,int to_ms,char * effBuf);
	if (!dev)
	{
		printf("error:pcap_open_live(): %s\n", errBuf);
		exit(1);
	}
	struct pcap_pkthdr packet;   //保持收到的数据包的 pacap_pkthdr 类型的指针
	/*
{	struct timeval ts;
	bpf_u_int32 caplen;
	bpf_u_int32 len
};

	*/
	const u_char * pktStr = pcap_next(dev,&packet);
	//u_char * pacp_next(pacp_t * dev,struct pcap_pkthdr * h)
	if(!pktStr)
	{
		printf("did not capture a packet!\n");
		exit(1);
	}
	printf("%s\n", pktStr);
	printf("Packet length: %d\nNumber of bytes:%d\n",packet.len,packet.caplen);
	printf("Recieved time:%s\n", ctime((const time_t *)&packet.ts.tv_sec));
	pcap_close(dev);
	//void pcap_close(pcap_t * dev)
	return 0;

} 