PATH="/Library/Frameworks/Python.framework/Versions/2.7/bin:${PATH}:/usr/local/Cellar/gettext/0.19.4/bin/"
export PATH

export LC_ALL=en_US.UTF-8

export EDITOR=nano
export JAVA_HOME=`/usr/libexec/java_home -v 1.8`
export AWS_IAM_HOME="/usr/local/opt/aws-iam-tools/jars"
export AWS_CREDENTIAL_FILE=$HOME/.ec2/credentials-gymora

export SSH_ENV=${HOME}/.ssh/environment
function start_agent {
  /usr/bin/ssh-agent | sed 's/^echo/#echo/' > ${SSH_ENV}
  chmod 600 ${SSH_ENV}
  source ${SSH_ENV} > /dev/null
  /usr/bin/ssh-add
}

[[ -s $(brew --prefix)/etc/autojump.sh ]] && . $(brew --prefix)/etc/autojump.sh
 
if [ -f $(brew --prefix)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
fi

if [ -f "${SSH_ENV}" ] ; then
  source ${SSH_ENV} > /dev/null
  ps -x | grep "^ *${SSH_AGENT_PID}" | grep ssh-agent$ > /dev/null || {
    start_agent
  }
else
  start_agent
fi

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

. ~/.bashrc

export PATH
export PKG_CONFIG_PATH=/opt/X11/lib/pkgconfig/
