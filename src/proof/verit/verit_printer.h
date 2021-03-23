/*********************                                                        */
/*! \file verit_printer.h
 ** \verbatim
 ** Top contributors (to current version):
 **   Hanna Lachnitt
 ** This file is part of the CVC4 project.
 ** Copyright (c) 2009-2020 by the authors listed in the file AUTHORS
 ** in the top-level source directory) and their institutional affiliations.
 ** All rights reserved.  See the file COPYING in the top-level source
 ** directory for licensing information.\endverbatim
 **
 ** \brief The module for printing veriT proof nodes
 **/

#ifndef CVC4__PROOF__VERIT_PROOF_PRINTER_H
#define CVC4__PROOF__VERIT_PROOF_PRINTER_H

#include "cvc4_private.h"
#include "expr/proof_node.h"
#include "proof/verit/verit_proof_rule.h"

#include <iostream>
#include <unordered_map>

namespace CVC4 {

namespace proof {

class VeritProofPrinter
{
 public:
  VeritProofPrinter(bool extended);
  ~VeritProofPrinter() {}
  /**
   * This method prints a proof node that has been transformed into the veriT
   * proof format
   *
   * @param out The stream to write to
   * @param pfn The proof node to be printed
   */
  void veritPrinter(std::ostream& out, std::shared_ptr<ProofNode> pfn);

 private:
  /** Used for printing after the initial anchor */
  std::string veritPrinterInternal(std::ostream& out,
                                   std::shared_ptr<ProofNode> pfn);
  /** Flag to indicate whether the veriT proof format should be extended */
  bool d_extended;
  /** The current level of nesting, which increases when in a subproof */
  int assumption_level;
  /** Current step id */
  int step_id;
  /** The current prefix which is updated whenever a subproof is encountered
   * E.g. prefix = "t19.t2." */
  std::string prefix;
  /** A list of assumption lists, one for every level of the nested proof node */
  std::vector<std::unordered_map<std::string,int>> assumptions;//TODO: Change to node
  /** A list of step lists, one for every level of the nested proof node */
  std::vector<std::unordered_map<std::string,int>> steps;
};

/**
 * This method prints a proof node that has been transformed into the veriT
 * proof format
 *
 * @param out The stream to write to
 * @param pfn The proof node to be printed
 */
static void veritPrinter(std::ostream& out, std::shared_ptr<ProofNode> pfn, bool extended)
{
  VeritProofPrinter vpp(extended);
  vpp.veritPrinter(out, pfn);
}

}  // namespace proof

}  // namespace CVC4

#endif
