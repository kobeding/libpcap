#include <stdio.h>
#include <pcap.h>

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
	pcap_t * dev = pcap_open_live(device,65535,1,-1,errBuf);
	//pcap_t * pcap_open_live(const char * device ,int snaplen,int promisc,int to_ms,char * effBuf);
	if (!dev)
	{
		printf("error:pcap_open_live(): %s\n", errBuf);
		exit(1);
	}
	struct pcap_pkthdr packet;
	const u_char * pktStr = pcap_next(dev,&packet);
	if(!pktStr)
	{
		printf("did not capture a packet!\n");
		exit(1);
	}
	printf("Packet length: %d\nNumber of bytes:%d\n,Recieved time:%s",packet.len,packet.caplen,packet.ts.tv_sec);
	pcap_close(dev);
	return 0;

} 