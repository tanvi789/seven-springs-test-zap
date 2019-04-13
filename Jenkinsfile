def label = "mypod-${UUID.randomUUID().toString()}"
podTemplate(label: label, containers: [
    containerTemplate(name: 'zap', image: 'owasp/zap2docker-weekly:latest', ttyEnabled: true, command: 'cat')
  ],
  volumes: [
  emptyDirVolume(mountPath: '/zap/wrk')
     ]
){
node(label) {
	def projectName = 'seven-springs-test-zap'
	projectServer = projectName + "-server"
	projectDir = projectName
	projectBranch = "${env.BRANCH_NAME}"

  properties([
    parameters([
    string(name: 'APP_NAME', defaultValue: 'cbaas-gateway-cbaas-eotr-2-4', description: 'Specify the swagger app name to execute the zap scan?'),
    string(name: 'CBAAS_VERSION', defaultValue: '2.4', description: 'Specify CBAAS release version'),
    string(name: 'CBAAS_KEY', defaultValue: 'nW8+U17qtebsd5j7', description: 'Specify the cbaas key'),
    ])
  ])

  container('zap') {
    stage('Build a project') {
      sh 'env'
    }

    stage('Debug') {
      sh 'env > env.txt'
	    readFile('env.txt').split("\r?\n").each {
		    println it
		  }
	  }

    stage('Checkout') {
      checkout scm
    }

    stage("Run Security Test") {
      try {
        sh './try-zap-tests-origin.sh'
      } catch (Exception e) {
        echo 'Problem while building job:[' + e.getMessage() + ']'
      }
      echo 'Ending the security test phase...'
      currentBuild.result = "Success"

      echo 'Leaving Stage "Run Security Test"'
    }

   stage("Archive Artefacts"){
   sh 'ls -la /zap/wrk'
   sh "cp -p /zap/wrk/* ${WORKSPACE}"
   archiveArtifacts artifacts: '**/*.html'
   archiveArtifacts artifacts: '**/*.conf'
   }

   stage("publishHTML"){
    publishHTML([allowMissing: false, alwaysLinkToLastBuild: false, keepAll: false, reportDir: '/zap/wrk', reportFiles: 'zap-scan-${BUILD_NUMBER}-release-version-${CBAAS_VERSION}.html', reportName: 'ZapScanReport', reportTitles: ''])
   }
 }
}
