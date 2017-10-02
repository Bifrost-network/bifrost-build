commit 4acd566457084980401f02017ea7bc30918f7ab0
Author: Andreas Jaggi <aj@open.ch>
Date:   Fri Sep 8 07:46:20 2017 -0400

    bgpd: Fix AS_PATH size calculation for long paths
    
    If you have an AS_PATH with more entries than
    what can be written into a single AS_SEGMENT_MAX
    it needs to be broken up.  The code that noticed
    that the AS_PATH needs to be broken up was not
    correctly calculating the size of the resulting
    message.  This patch addresses this issue.
    
    This patch was built from an email that Andreas
    sent to the dev alias for FRRouting.
    
    Fixes: #1114
    Signed-off-by: Andreas Jaggi <aj@open.ch>
    Signed-off-by: Donald Sharp <sharpd@cumulusnetworks.com>

diff --git a/bgpd/bgp_aspath.c b/bgpd/bgp_aspath.c
index 89a529d7..240d3794 100644
--- a/bgpd/bgp_aspath.c
+++ b/bgpd/bgp_aspath.c
@@ -952,7 +952,7 @@ aspath_put (struct stream *s, struct aspath *as, int use32bit )
               assegment_header_put (s, seg->type, AS_SEGMENT_MAX);
               assegment_data_put (s, seg->as, AS_SEGMENT_MAX, use32bit);
               written += AS_SEGMENT_MAX;
-              bytes += ASSEGMENT_SIZE (written, use32bit);
+              bytes += ASSEGMENT_SIZE (AS_SEGMENT_MAX, use32bit);
             }
           
           /* write the final segment, probably is also the first */
