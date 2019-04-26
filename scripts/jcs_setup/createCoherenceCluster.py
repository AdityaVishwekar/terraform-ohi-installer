edit()
startEdit()
## Claims Cluster
coh1=create('claims_coherence_cluster', 'CoherenceClusterSystemResource')
cd('CoherenceClusterSystemResources/claims_coherence_cluster/CoherenceClusterResource/claims_coherence_cluster/CoherenceClusterParams/claims_coherence_cluster')
set('ClusterListenPort', 7575)
cd('../../../../../../Servers/ohi-app-_server_1')
set('CoherenceClusterSystemResource', coh1)
cd('../../')
## Default Cluster
coh2=create('defaultCoherenceCluster1', 'CoherenceClusterSystemResource')
cd('CoherenceClusterSystemResources/defaultCoherenceCluster1/CoherenceClusterResource/defaultCoherenceCluster1/CoherenceClusterParams/defaultCoherenceCluster1')
set('ClusterListenPort', 7574)
cd('../../../../../../Servers/ohi-app-_adminserver')
set('CoherenceClusterSystemResource', coh2)
cd('../../Clusters/ohi-app-_cluster')
set('CoherenceClusterSystemResource', 0)
save()
activate()
# Update the listern port and add member cluster
#Reference - https://docs.oracle.com/middleware/1212/wls/CLUST/coherence.htm#CLUST671
# https://www.oracle.com/webfolder/technetwork/tutorials/obe/fmw/wls/12c/06-WLST--4474/cmdline.htm

# Update the listern port and add member cluster
#Reference - https://docs.oracle.com/middleware/1212/wls/CLUST/coherence.htm#CLUST671
# https://www.oracle.com/webfolder/technetwork/tutorials/obe/fmw/wls/12c/06-WLST--4474/cmdline.htm
#connect('weblogic','Ach1z0#d','t3://129.213.26.129:7001')