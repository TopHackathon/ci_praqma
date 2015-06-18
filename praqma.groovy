import hudson.model.*;
import jenkins.model.*;


Thread.start {
      sleep 10000
      println "--> adding praqma template job"

      def jobName1 = "praqma-job"
      def configXml1 = new File('/var/jenkins_home/templates/praqma_config.xml').getText('UTF-8')
      def xmlStream1 = new ByteArrayInputStream( configXml1.getBytes() )
      Jenkins.instance.createProjectFromXML(jobName1, xmlStream1)
}

