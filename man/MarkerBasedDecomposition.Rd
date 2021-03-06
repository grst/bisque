% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/marker_based.R
\name{MarkerBasedDecomposition}
\alias{MarkerBasedDecomposition}
\title{Performs marker-based decomposition of bulk expression using marker genes}
\usage{
MarkerBasedDecomposition(
  bulk.eset,
  markers,
  ct_col = "cluster",
  gene_col = "gene",
  min_gene = 5,
  max_gene = 200,
  weighted = FALSE,
  w_col = "avg_logFC",
  unique_markers = TRUE,
  verbose = TRUE
)
}
\arguments{
\item{bulk.eset}{Expression Set. Normalized bulk expression data.}

\item{markers}{Data frame with columns specifying cluster and gene,
and optionally a column for weights, typically the fold-change of the gene.
Important that the genes for each cell type are row-sorted by signficance.}

\item{ct_col}{Character string. Column name specifying cluster/cell type
corresponding to each marker gene in \strong{markers}.}

\item{gene_col}{Character string. Column name specifying gene names in
\strong{markers}.}

\item{min_gene}{Numeric. Min number of genes to use for each cell type.}

\item{max_gene}{Numeric. Max number of genes to use for each cell type.}

\item{weighted}{Boolean. Whether to use weights for gene prioritization}

\item{w_col}{Character string. Column name for weights, such as "avg_logFC",
in \strong{markers}}

\item{unique_markers}{Boolean. If TRUE, subset markers to include only genes 
that are markers for only one cell type}

\item{verbose}{Boolean. Whether to print log info during decomposition.
Errors will be printed regardless.}
}
\value{
A List. Slot \strong{bulk.props} contains estimated relative cell
  type abundances. Slot \strong{var.explained} contains variance explained by
  first 20 PCs for cell type marker genes. Slot \strong{genes.used} contains
  vector of genes used for decomposition.
}
\description{
Estimates relative abundances of cell types from PCA-based decomposition.
Uses a list of marker genes to subset the expression data, and returns the 
first PC of each sub-matrix as the cell type fraction estimates.
Optionally, weights for each marker gene can be used to prioritize genes
that are highly expressed in the given cell type.
}
\details{
Note that this method expects the input bulk data to be normalized, unlike
the reference-based method.
}
\examples{
library(Biobase)
sim.data <- SimulateData(n.ind=10, n.genes=100, n.cells=100,
                         cell.types=c("Neurons", "Astrocytes", "Microglia"),
                         avg.props=c(.5, .3, .2))
res <- MarkerBasedDecomposition(sim.data$bulk.eset, sim.data$markers, weighted=FALSE)
estimated.cell.proportions <- res$bulk.props

}
