
# AWS

alias k='kubectl'

# Checking and setting the kubectl context
alias kcgc='kubectl config get-contexts'
alias kcgcc="kubectl config get-contexts | grep '^*' | awk '{print \$2}'"
alias kcuc='kubectl config use-context'

# Dealing with evicted pods
alias kubectl-evicted-details="kubectl get pod --all-namespaces -o json | jq '.items[] | select(.status.reason!=null) | select(.status.reason | contains(\"Evicted\"))' | jq -C"
alias kubectl-evicted-reason="kubectl get pod --all-namespaces -o json | jq '.items[] | select(.status.reason!=null) | select(.status.reason | contains(\"Evicted\"))' | jq -s '[.[] | {namespace: .metadata.namespace, message: .status.message, time: .status.startTime}] | sort_by(.time)' | jq -C"
alias kubectl-evicted-list="kubectl get pod --all-namespaces -o json | jq '.items[] | select(.status.reason!=null) | select(.status.reason | contains(\"Evicted\")) | \"\(.metadata.name) \(.status.message)\" ' | sed 's/\"//g'"
alias kubectl-evicted-list-uniq="kubectl get pod --all-namespaces -o json | jq '.items[] | select(.status.reason!=null) | select(.status.reason | contains(\"Evicted\")) | \"\(.metadata.namespace)\" ' | sed 's/\"//g' | sort | uniq"
alias kubectl-evicted-count='kubectl-evicted-list | wc -l'
alias kubectl-evicted-DELETE="kubectl get pod --all-namespaces -o json | jq '.items[] | select(.status.reason!=null) | select(.status.reason | contains(\"Evicted\")) | \"kubectl delete pod \(.metadata.name) -n \(.metadata.namespace)\"' | xargs -n 1 bash -c"

# short aliases for evicted pods
alias kcce=kubectl-evicted-count
alias kcleu=kubectl-evicted-list-uniq
alias kcle=kubectl-evicted-list
alias kcre=kubectl-evicted-reason
alias kcde=kubectl-evicted-details
alias kcDE=kubectl-evicted-DELETE

# List node external DNS
function cluster-nodes() {
  kubectl describe nodes | grep ExternalDNS | sed 's/.*ec2/ec2/'
}

# List commands to ssh into nodes
function cluster-ssh() {
  kubectl describe nodes | grep ExternalDNS | sed 's/.*ec2/ec2/;s/^/ssh ec2-user@/'
}

# Check memory usage
# (you must be listed in the nodes' authorized_keys)
function cluster-mem() {
  for node in $(cluster-nodes)
  do
    total=$(ssh ec2-user@$node 'head -n1 /proc/meminfo | awk "{print \$2}"')
    # TODO: mem usage is notoriously difficult to pin down
    # using /proc/meminfo line 2 might be overly pessimistic
    free=$(ssh ec2-user@$node 'head -n2 /proc/meminfo | tail -n1 | awk "{print \$2}"')
    python -c "print('{:7.2%} free'.format($free/$total))"
  done
}


