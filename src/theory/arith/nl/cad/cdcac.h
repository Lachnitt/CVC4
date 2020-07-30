/*********************                                                        */
/*! \file cdcac.h
 ** \verbatim
 ** Top contributors (to current version):
 **   Gereon Kremer
 ** This file is part of the CVC4 project.
 ** Copyright (c) 2009-2020 by the authors listed in the file AUTHORS
 ** in the top-level source directory) and their institutional affiliations.
 ** All rights reserved.  See the file COPYING in the top-level source
 ** directory for licensing information.\endverbatim
 **
 ** \brief Implements the CDCAC approach.
 **
 ** Implements the CDCAC approach as described in
 ** https://arxiv.org/pdf/2003.05633.pdf.
 **/

#include "cvc4_private.h"

#ifndef CVC4__THEORY__ARITH__NL__CAD__CDCAC_H
#define CVC4__THEORY__ARITH__NL__CAD__CDCAC_H

#include <poly/polyxx.h>

#include <vector>

#include "theory/arith/nl/cad/cdcac_utils.h"
#include "theory/arith/nl/cad/constraints.h"
#include "theory/arith/nl/cad/variable_ordering.h"
#include "theory/arith/nl/nl_model.h"

namespace CVC4 {
namespace theory {
namespace arith {
namespace nl {
namespace cad {

/**
 * This class implements Cylindrical Algebraic Coverings as presented in
 * https://arxiv.org/pdf/2003.05633.pdf
 */
class CDCAC
{
 public:
  /** Initialize without a variable ordering. */
  CDCAC();
  /** Initialize this method with the given variable ordering. */
  CDCAC(const std::vector<poly::Variable>& ordering);

  /** Reset this instance. */
  void reset();

  /** Collect variables from the constraints and compute a variable ordering. */
  void computeVariableOrdering();

  /**
   * Returns the constraints as a non-const reference. Can be used to add new
   * constraints.
   */
  Constraints& getConstraints();
  /** Returns the constraints as a const reference. */
  const Constraints& getConstraints() const;

  /**
   * Returns the current assignment. This is a satisfying model if
   * get_unsat_cover() returned an empty vector.
   */
  const poly::Assignment& getModel() const;

  /** Returns the current variable ordering. */
  const std::vector<poly::Variable>& getVariableOrdering() const;

  /**
   * Collect all unsatisfiable intervals for the given variable.
   * Combines unsatisfiable regions from d_constraints evaluated over
   * d_assignment. Implements Algorithm 2.
   */
  std::vector<CACInterval> getUnsatIntervals(std::size_t cur_variable) const;

  /**
   * Collects the coefficients required for projection from the given
   * polynomial. Implements Algorithm 6.
   */
  std::vector<poly::Polynomial> requiredCoefficients(
      const poly::Polynomial& p) const;

  /**
   * Constructs a characterization of the given covering.
   * A characterization contains polynomials whose roots bound the region around
   * the current assignment. Implements Algorithm 4.
   */
  std::vector<poly::Polynomial> constructCharacterization(
      std::vector<CACInterval>& intervals);

  /**
   * Constructs an infeasible interval from a characterization.
   * Implements Algorithm 5.
   */
  CACInterval intervalFromCharacterization(
      const std::vector<poly::Polynomial>& characterization,
      std::size_t cur_variable,
      const poly::Value& sample);

  /**
   * Main method that checks for the satisfiability of the constraints.
   * Recursively explores possible assignments and excludes regions based on the
   * coverings. Returns either a covering for the lowest dimension or an empty
   * vector. If the covering is empty, the result is SAT and an assignment can
   * be obtained from d_assignment. If the covering is not empty, the result is
   * UNSAT and an infeasible subset can be extracted from the returned covering.
   * Implements Algorithm 2.
   */
  std::vector<CACInterval> getUnsatCover(std::size_t cur_variable = 0);

 private:
  /**
   * The current assignment. When the method terminates with SAT, it contains a
   * model for the input constraints.
   */
  poly::Assignment d_assignment;

  /** The set of input constraints to be checked for consistency. */
  Constraints d_constraints;

  /** The computed variable ordering used for this method. */
  std::vector<poly::Variable> d_variableOrdering;

  /** The object computing the variable ordering. */
  VariableOrdering d_varOrder;
};

}  // namespace cad
}  // namespace nl
}  // namespace arith
}  // namespace theory
}  // namespace CVC4

#endif