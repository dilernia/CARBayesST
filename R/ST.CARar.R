ST.CARar <- function(formula, family, data=NULL,  trials=NULL, W, burnin, n.sample, thin=1, prior.mean.beta=NULL, 
                     prior.var.beta=NULL, prior.nu2=NULL, prior.tau2=NULL, rho.S=NULL, rho.T=NULL, MALA=TRUE, 
                     verbose=TRUE, rho.S.init = NULL, rho.T.init = NULL, proposal.sd.rho.S = 0.05, proposal.sd.rho.T = 0.05,
                          proposal.sd.beta = 0.01)
{
    ## This is a wrapper function for the following three functions.
    ## binomial.CARar
    ## gaussian.CARar
    ## poisson.CARar
    if(is.null(family)) stop("the family argument is missing", call.=FALSE)
    
    #### Run the appropriate model according to the family arugment
    if(family=="binomial")
    {
        if(is.null(trials)) stop("a binomial model was specified but the trials arugment was not specified", call.=FALSE)
        model <- binomial.CARar(formula=formula, data=data,  trials=trials, W=W, burnin=burnin, n.sample=n.sample, thin=thin, prior.mean.beta=prior.mean.beta, prior.var.beta=prior.var.beta, prior.tau2=prior.tau2, rho.S=rho.S, rho.T=rho.T, MALA=MALA, verbose=verbose)
    }else if(family=="gaussian")
    {
        if(!is.null(trials)) stop("you do not need a trials arugment as a binomial model was not specified", call.=FALSE)
        model <- gaussian.CARar(formula=formula, data=data,  W=W, burnin=burnin, n.sample=n.sample, thin=thin, prior.mean.beta=prior.mean.beta, prior.var.beta=prior.var.beta, prior.nu2=prior.nu2, prior.tau2=prior.tau2, rho.S=rho.S, rho.T=rho.T, verbose=verbose)          
    }else if(family=="poisson")
    {
        if(!is.null(trials)) stop("you do not need a trials arugment as a binomial model was not specified", call.=FALSE)
        model <- poisson.CARar(formula=formula, data=data,  W=W, burnin=burnin, n.sample=n.sample, thin=thin, 
                               prior.mean.beta=prior.mean.beta, prior.var.beta=prior.var.beta, 
                               prior.tau2=prior.tau2, rho.S=rho.S, rho.T=rho.T, MALA=MALA, 
                               verbose=verbose, rho.S.init = rho.S.init, rho.T.init = rho.T.init,
                               proposal.sd.rho.S = proposal.sd.rho.S, proposal.sd.rho.T = proposal.sd.rho.T)          
    }else
    {
        stop("the family arugment is not one of `binomial', `gaussian' or `poisson'.", call.=FALSE)     
    }
    return(model)     
}
