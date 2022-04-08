# ParetoFront Ensemble Metric
*Back to [[SimpleMetrics]] page.*
## ParetoFront Ensemble Metric

[[_TOC_]]

### Author and history

Created Friday, 8 April 2022 by Vikram K. Mulligan, Center for Computational Biology, Flatiron Institute (vmulligan@flatironinstitute.org).  This was the fourth [[EnsembleMetric|EnsembleMetrics]] completed.

### Description

The Pareto front is the subset of elements in a set that are optimal for more than one property, in the sense that no element in the set has a value that is more optimal for one property without also having a value that is less optimal for another property.  In other words, you can't make one property better without sacrificing another property.  When plotted in N-dimensional space (where N is the number of properties), the Pareto front is the "rim" of the point cloud, as shown below.  The ParetoFront ensemble metric identify the poses at the Pareto front for two or more properties (as measured by [[SimpleMetrics]]).  This is useful in situations in which one is seeking diverse structures optimized for more than one property, and the optimal trade-off between one property and another is unknown.  For example, if one were designing proteins to bind to a target, one might want the proteins to have low overall Rosetta scores in isolation, low interface interaction scores, and low numbers of buried unsatisfied hydrogen bond donors and acceptors.  In this case, the Pareto optimal designs would be the ones in which, for instance, one couldn't improve the Rosetta score without worsening either the interface score or the number of buried unsatisfied hydrogen bond donors/acceptors.

[[/images/ensemble_metrics/pareto_front/pareto_front.png]]

In the plot above, a set of structures are plotted by Rosetta energy (horizontal axis) and solvent-exposed polar surface area (vertical axis).  If low energy and high exposed polar surface area were both desirable properties, the set of orange points, lying at the Pareto front, would be the ones of interest, since these are the ones in which one of these properties cannot be made better without sacrificing the other property.

#### Details

The ParetoFront ensemble metric accepts as input two or more real-valued [[SimpleMetrics]], as well as a comma-separated list of Boolean values indicating whether it is desirable to have lower (true) or higher (false) value for each property measured by each [[SimpleMetric|SimpleMetrics]].  It then applies these [[SimpleMetrics]] to each pose in an ensemble, collecting a series of values.  At reporting time, the metric returns three lists:

- A table of those poses at the Pareto front, with the corresponding values of each [[SimpleMetric|SimpleMetrics]].
- A table of _all_ poses seen with the values of each [[SimpleMetric|SimpleMetrics]] and a Boolean "TRUE" or "FALSE" indicating whether each is at the Pareto Front.
- Optionally, a list of binary silent strings representing those poses at the Pareto front.  These can be copied into separate text files and converted to PDB files using Rosetta's [[extract_pdbs|Apps]] application.  Note that if this option is used, more memory is required.

### Usage

#### Interface

[[include:ensemble_metric_ParetoFront_type]]

#### Example configuration in RosettaScripts

In this example, an input PDB file containing a single 8-residue cyclic peptide is perturbed and redesigned.  The score and polar solvent-exposed surface area of each design are measured using a [[TotalEnergyMetric]] and a [[SasaMetric]] (two [[SimpleMetrics]]), respectively.  The ParetoFront ensemble metric then returns a list of the peptides that have high polar solvent-exposed surface area and low total score (i.e. those at the Pareto front for these two properties).

```xml
<ROSETTASCRIPTS>
	# Generate a bunch of perturbations of a cyclic peptide input, design each, and select
	# designs at the Pareto front of low score and high polar SASA.
	<SCOREFXNS>
		<ScoreFunction name="r15" weights="ref2015.wts" >
			<Reweight scoretype="chainbreak" weight="5.0" />
		</ScoreFunction>
	</SCOREFXNS>
	<RESIDUE_SELECTORS>
		<Phi name="select_pos_phi" select_positive_phi="true" />
		<Not name="select_neg_phi" selector="select_pos_phi" />
	</RESIDUE_SELECTORS>
	<TASKOPERATIONS>
		<RestrictToSpecifiedBaseResidueTypes name="limited_selection" base_types="ALA,ASP,VAL,THR,PHE,DALA,DASP,DVAL,DTHR,DPHE,ORN,DORN" />
		<RestrictToResidueProperties name="d_pos_phi" selector="select_pos_phi" properties="D_AA" />
		<RestrictToResidueProperties name="l_neg_phi" selector="select_neg_phi" properties="L_AA" />
	</TASKOPERATIONS>
	<PACKER_PALETTES>
		<CustomBaseTypePackerPalette name="design_palette" additional_residue_types="DALA,DASP,DVAL,DTHR,DPHE,DORN,ORN" />
	</PACKER_PALETTES>
	<MOVERS>
		<DeclareBond name="connect_termini" res1="8" res2="1" atom1="C" atom2="N" add_termini="true" />

		<GeneralizedKIC name="perturb1" selector_scorefunction="r15" closure_attempts="200" stop_when_n_solutions_found="1" selector="lowest_rmsd_selector" >
			<AddResidue res_index="3"/>
			<AddResidue res_index="4"/>
			<AddResidue res_index="5"/>
			<AddResidue res_index="6"/>
			<AddResidue res_index="7"/>
			<SetPivots res1="3" atom1="CA" res2="5" atom2="CA" res3="7" atom3="CA" />
			<AddPerturber effect="perturb_dihedral" >
				<AddAtoms res1="3" atom1="N" res2="3" atom2="CA" />
				<AddAtoms res1="3" atom1="CA" res2="3" atom2="C" />
				<AddAtoms res1="4" atom1="N" res2="4" atom2="CA" />
				<AddAtoms res1="4" atom1="CA" res2="4" atom2="C" />
				<AddAtoms res1="5" atom1="N" res2="5" atom2="CA" />
				<AddAtoms res1="5" atom1="CA" res2="5" atom2="C" />
				<AddAtoms res1="6" atom1="N" res2="6" atom2="CA" />
				<AddAtoms res1="6" atom1="CA" res2="6" atom2="C" />
				<AddAtoms res1="7" atom1="N" res2="7" atom2="CA" />
				<AddAtoms res1="7" atom1="CA" res2="7" atom2="C" />
				<AddValue value="10.0"/>
			</AddPerturber>
		</GeneralizedKIC>

		<GeneralizedKIC name="perturb2" selector_scorefunction="r15" closure_attempts="200" stop_when_n_solutions_found="1" selector="lowest_rmsd_selector" >
			<AddResidue res_index="7"/>
			<AddResidue res_index="1"/>
			<AddResidue res_index="2"/>
			<AddResidue res_index="3"/>
			<AddResidue res_index="4"/>
			<SetPivots res1="7" atom1="CA" res2="2" atom2="CA" res3="4" atom3="CA"></SetPivots>
			<AddPerturber effect="perturb_dihedral" >
				<AddAtoms res1="7" atom1="N" res2="7" atom2="CA" />
				<AddAtoms res1="7" atom1="CA" res2="7" atom2="C" />
				<AddAtoms res1="1" atom1="N" res2="1" atom2="CA" />
				<AddAtoms res1="1" atom1="CA" res2="1" atom2="C" />
				<AddAtoms res1="2" atom1="N" res2="2" atom2="CA" />
				<AddAtoms res1="2" atom1="CA" res2="2" atom2="C" />
				<AddAtoms res1="3" atom1="N" res2="3" atom2="CA" />
				<AddAtoms res1="3" atom1="CA" res2="3" atom2="C" />
				<AddAtoms res1="4" atom1="N" res2="4" atom2="CA" />
				<AddAtoms res1="4" atom1="CA" res2="4" atom2="C" />
				<AddValue value="10.0"/>
			</AddPerturber>
		</GeneralizedKIC>

		<FastDesign name="fdes" repeats="1" scorefxn="r15" packer_palette="design_palette" task_operations="d_pos_phi,l_neg_phi,limited_selection" />
	</MOVERS>
	<SIMPLE_METRICS>
		<TotalEnergyMetric name="total_energy" scorefxn="r15" />
		<SasaMetric name="sasa" sasa_metric_mode="polar_sasa" />
	</SIMPLE_METRICS>
	<ENSEMBLE_METRICS>
		<ParetoFront name="paretofront" lower_is_better="true,false" real_metrics="total_energy,sasa" />
	</ENSEMBLE_METRICS>
	<PROTOCOLS>
		<Add mover="connect_termini" />
		<Add mover="perturb1" />
		<Add mover="perturb2" />
		<Add mover="fdes" />
		<Add ensemble_metrics="paretofront" />
	</PROTOCOLS>
	<OUTPUT scorefxn="r15" />
</ROSETTASCRIPTS>
```

#### Example output

The output from the example above is shown below:

```
protocols.ensemble_metrics.metrics.ParetoFrontEnsembleMetric: (0) Report from ParetoFront:
	MPI_process:	0
	poses_in_ensemble:	20
Poses at Parteo front:
Pose	Metric_1	Metric_2
teststruct_0001	-10.9948	562.189
teststruct_0010	-11.1487	561.375
teststruct_0011	-14.4376	533.249
teststruct_0014	-11.3264	538.945
teststruct_0003	-15.1701	423.254
teststruct_0009	-13.7229	536.632
End poses at Parteo front
All poses:
Pose	Metric_1	Metric_2	At_Pareto_front?
teststruct_0001	-10.9948	562.189	TRUE
teststruct_0004	-9.58659	464.091	FALSE
teststruct_0007	-7.11429	476.887	FALSE
teststruct_0010	-11.1487	561.375	TRUE
teststruct_0013	8.69142	460.517	FALSE
teststruct_0016	-7.30785	560.823	FALSE
teststruct_0019	-11.5179	475.092	FALSE
teststruct_0002	-5.46091	504.822	FALSE
teststruct_0005	-8.69703	536.107	FALSE
teststruct_0008	-11.6457	509.571	FALSE
teststruct_0011	-14.4376	533.249	TRUE
teststruct_0014	-11.3264	538.945	TRUE
teststruct_0017	-13.9076	524.441	FALSE
teststruct_0020	-13.8797	495.925	FALSE
teststruct_0003	-15.1701	423.254	TRUE
teststruct_0006	6.03388	470.449	FALSE
teststruct_0009	-13.7229	536.632	TRUE
teststruct_0012	-7.75434	546.179	FALSE
teststruct_0015	-6.62836	500.375	FALSE
teststruct_0018	-13.6551	526.151	FALSE
End all poses
Full poses at pareto front:
[BEGIN 1: teststruct_0001]
SEQUENCE: DXDXDXDX
SCORE:     score     fa_atr     fa_rep     fa_sol    fa_intra_rep    fa_intra_sol_xover4    lk_ball_wtd    fa_elec    pro_close    hbond_sr_bb    hbond_lr_bb    hbond_bb_sc    hbond_sc    dslf_fa13      omega     fa_dun    p_aa_pp    yhh_planarity        ref    chainbreak    rama_prepro     description
REMARK BINARY SILENTFILE
ANNOTATED_SEQUENCE: D[DASP]X[DORN]DX[DORN]DX[ORN]DX[ORN] teststruct_0001
NONCANONICAL_CONNECTION: 8  C   1  N  
LezeTCj5dUCkvdOWvoEoTCj7p+C0yS0wPaUwSC7qnfDEJ69hvl31SCTm8CEU5OqfP2rFVCXrCNDkfuPwPu7/VCLbAxCECO76PXYmVC3SVlCkFNyBQ/ZFXC3ZinCU8002Pni2TCTZYPCEgBt3v+8TTCHWp8CES/v8PYycVCXvfMDEQkNwvOZKVCDN8tDUOC81P teststruct_0001
L5i6RCvZhQD0yyk4vlF+QCT+SsD00YH+vy8hPCPC8fDUj6j7vT2pOCDCb7DUKQ06vCLNRCvLtqDEIXGFwsapSCbv3yDEcAyGwXUxSCPNW2DkFmaKwbJMUCHBT1DUvuTLwHl7RCby/wCERCW6vsNIRCL7dGEEOFU7vjg6QCbsYLD0hHoGwg9kQCz2PBEUKEEHwV+/SCH0RIE0cL+EwzyRTC7fvYD0SdYFwnLPSC/32bDkYqWLwNmUSC/dIKEkNiFLw6nOUCfNs3DUolUNwIRsUCDGBHEUgseKwITnUCnxdZD0/vuKw teststruct_0001
LQzSPCjKc2CERFP6vve+NCHwmmC0iZb2vVLCNC3jxlC0QXZAwtysMCPLrDCUdhdCweUFOCftdzBEYahpvUKwMCrZESBUkblmP4h4LCDMmCCUFehvPRknMCnMxFAkuivrPG8CQCDOVhCU7mW7vztjNCPqB8CkmxlhvPUzOCfpJ0BkrtWwPlOdOCnmEHB0mUa4v teststruct_0001
Lr8mMCL1jLDEfFJCwnTuLCDuTPD0ADwGwNsdMC75yCDEjp5JwSzdNCbUjWDUpunKwwHLLCzdz8DEYMQHwH7LKCnVgBEkTa6Jw/FpJCf4OYEkMo9JwfqrICfekbE05tMMwIA6MCn2YmD0/bOAwWIzKC77/7CULsOGwp/qKCTu3CEkw8iDwB6/LCDyjJE0lN2HwGsrKCzIZ8Dks3zLwUyWJCz+usDkvvrJwZjIJCz0nbEUyGFIwv3dKC3YfjEkZKMKwGHWICHmzqE08aKMwuWJJCH/vYEk7Y9NwGy5HC3MbREkPp/Lw teststruct_0001
LN2AMC/+shCUM5WLw/QtMC7QxTCkoWxNwiAxNC/IJlB0NgGNw64aOCjLcCB0ak4OwA+tLCzVRBCU5SzPw2quKCb4YiCkK4aQwv0/KC7Z1HD0CISQwLytJCvD7VC08r8Qw4YLLCXnFSCU+uxKwyJINCjT1vC0qazOw+PKLCnZUOBESd4OwoCRMCjXBoBUm1vQw teststruct_0001
L147NCv8eTBkdkhKwwn7OCD9yVAkronJwE6LQCDzoCBEdGnIwzcJQCrC4wBkNAPFwhhWOCDaG5+juc2GwvLLNCL6kW8zaHUIwc8qMCHXdU67BhFEwLWGMC/mpD8z5uQ/vt9WNCf0fxBEyDKJwfaNPCr2ua/jZdTLwWQBOC/ODEA00pgDwqQIPCPXjH9zlkWFwpyeNCvVnD1rRi+JwxOXMCnzod+jJY/IwCqfNCPm4j9LG7hCw2l5LCbEf29LcglFwotxLCnpeU3LwWa5v8qULCTCAI+jFWABwMwzMCvquQ+jyhT8v teststruct_0001
LyETRCzXx0AUwAAKwawiSCrOIhB0zJYJwIZBTC3XyLB0oBIFwW4xTC/qU8BUePtCw+QoTCzGvJBEvCaLwjF7UCjfR7BEf2+KwTb5UCX5IkCkFlMLw6M7VCDuoTBEtncKwB+RRCXCcKAE0rhLw3AZSCvXQTCEnZmJwpBRTCn/YWBEzKbNwoH2TCXVeFAELfRLw teststruct_0001
LQ59SCXZd2/zqLpDwBXYTCL2r/+Trxo8vF5MSCrI89+zRj1xv3ulRCfSAi7zTJOsvkyBUCXQhn3jqIH9vkdVVCLOiA2jEHrBwe26VCf+wr+rmetBwh1MXCD/F0+73nuEwo7oSCzg9d+jE/RGwfuHUCHgFNAUWRo5vphVTCHeuX8rjjZAwKnOUCbbZ057ksByvAmDWCLyd+8Dg6t/vmKKVC7byC7TuDyFwbTNVCf23BAMPFjDwIiGWCPcWV/7mhO7vagjXCbclWAM7CqEwQA4XC/weJ9L+cBDwxvCXCTrBQ+L3yRIw teststruct_0001

[END 1: teststruct_0001]
[BEGIN 2: teststruct_0010]
SEQUENCE: TXDXDXDD
SCORE:     score     fa_atr     fa_rep     fa_sol    fa_intra_rep    fa_intra_sol_xover4    lk_ball_wtd    fa_elec    pro_close    hbond_sr_bb    hbond_lr_bb    hbond_bb_sc    hbond_sc    dslf_fa13      omega     fa_dun    p_aa_pp    yhh_planarity        ref    chainbreak    rama_prepro     description
REMARK BINARY SILENTFILE
ANNOTATED_SEQUENCE: T[DTHR]X[DORN]DX[DORN]DX[ORN]DD teststruct_0010
NONCANONICAL_CONNECTION: 8  C   1  N  
LTtNTCv1FVCU8nZhPRZETCrUm5C0NZW4Pi5ISC/2ObDEfncuPXgmRCTJN2DUk+W5P62bUCD59ND0DK36PPaCVCH67cD00aNhP60WVCDwhtCUWxEAQ3AfTCDzNaCUwfA1vO/oSCDsWuC0lh3/Pq9SUCL4FpDUXSHAQDhfUCrpGzDEjYKnvAUUWC/Kf8CExy7AQfB6UCHxWiC0ApyDQ6cgVCH+dSC0riy6P teststruct_0010
LiA9RCLMdZD0rp01vt2CRCHQo2Dkg0Y8v6BnPC7QOmDEQZA8vuJrOCX2w+D0HcM6vb6eRCHTI9DEa6/DwWB1SCTYsJEUpqoEw5qJTCn4sNEUm6PJwDycUCLDAZEE40lJwaDdSCj3TDDEmFO7vDxERCLNqKEE7GQ4vJ4iRCnPMeDUP+/FwkDvQCP+DIEEcqGGw9zzSC/t9YEkhohCwkKnTCjmj/DkXU5CwAsMTCX678DUazTKwWRXSC/zZXEk9LJKwwFoUCD1WbEUPvjLwdcaUCX8RnEE2VpIwRTMVCTWDQEE/SzIw teststruct_0010
LSacPCj9m8CkH1u9vp+HOCzJ1oCUBWf9v7LXNCHvWxCE/e6Dw9WJNCjdVUCUNBIHwupPOCPCGxBEmuq7vuK5MC7/UEBU1IM7vQo6LCDciuBkMpE5vpe2MCz7uw/jzi88vhKQQCz4NqCUVKQ/v71jNCvFn2CUfvv1vSnxOCvEMlBUUAZwvmP1OC3hrUBkUQDBw teststruct_0010
LbO9MCPsXZDkTFsEwrnOMCXw5lDEAsvIwgeHNC7k8gDkkhLLwgEJOCD6Y2DU8FbLwKbuLCLo/JEkOjhIwe3sKCrpmNEUAcoEwPcOKCjQukEUsyhEwGWOJCrJhoEkIpOAwQIKNCnHsvDUaK4BwkKSLCrUfTD0MF+IwNXkMC3aqUEUT+JIwXVRLCX+yOEEnbaKwV71JCDsJDEEslRFwtUJLCDIsJEkznxAwB/ELCn9SvEkhx3Dw5dxJCrpvoE0UqLIwjz7ICnBA4EU64SAwq7aICnlAfE0jI1AwKtoJCL6HlEUl1R5v teststruct_0010
LwcxMCH7uEDkOdFNwzhlNCH1E/CEMvePwsBpOCjFzcCUzYCPw8QbPCbMATCkxqaQwOjtMCHBGzCU2G8QwkvwLCff0WDUYeWRwymKMCPuP7DEknURw8BpKCX1VNDEvNsRwQ17LCDaCzC0HL3Mw1lBOCHCCeDUs5BQwh+HMCnOuWCUmtsQw6NWNCnQIrC0OiyRw teststruct_0010
LtSqOCj/iKC0fzoMwpprPCbA2WBEnf5LwTzyQCLZQACkplRKw+giQCXVSUCkAxNIwV+DPCXr8MAUUjUKw+p/NCvmU2+jbl1LwJEZNC7Uon6Tr6GKwbJnMCnG3h9zQJqHwDu8NCLiZSC0QqSLwpmHQCXx18AEVHuNweAnOCvhmlA0AjfIwb+1PC/wCA/TbJvJwA5bOCbOH59DUcnNwIANNCL+qGA0JwdMwVEMOCn1Yb6LMOUJwvtuMC3fGV6rhgULwdpOMC3N1+3DPAeFwc82LCvkS6+jkZiIwO5NNCnm24+D5YVFw teststruct_0010
L6xBSCrL62BUStNLwiELTCje9PCkrN8JwSEUTCT43BCk2yEGwTFoTCDlqbCExjkCwoddUCjUtFCUJ8dLwxpjUCn6HdCkhbIOw3R0TCLdB7CEGshOw9rXVC7v4QC0ZvvPwrTLSCLxRSB0Zg2MwjtDTCL06yCkufEKwS/gUCXrwGBkY01LwuoUVCfEYOCUC1PKw teststruct_0010
LheFTCT89uAUyqPFwtNQTCbNlIAkmR8/vU//RCL20TA0BAK5vSWKRC7hs0+D4Mh4vyklTCTgRl8TqbeAw4L3TCT7bCy7DxZ0v9zpTCftde8j6mzmPn1RUCjgJT+LCrS0vOyxSCfs6JA0RLKIwtGFUCjyooA00t57v4sdUCLmmF8jZMBDwegwSCv0MB4zroZCw teststruct_0010

[END 2: teststruct_0010]
[BEGIN 3: teststruct_0011]
SEQUENCE: DXDXDXDX
SCORE:     score     fa_atr     fa_rep     fa_sol    fa_intra_rep    fa_intra_sol_xover4    lk_ball_wtd    fa_elec    pro_close    hbond_sr_bb    hbond_lr_bb    hbond_bb_sc    hbond_sc    dslf_fa13      omega     fa_dun    p_aa_pp    yhh_planarity        ref    chainbreak    rama_prepro     description
REMARK BINARY SILENTFILE
ANNOTATED_SEQUENCE: D[DASP]X[DORN]DX[DORN]DX[ORN]DX[ORN] teststruct_0011
NONCANONICAL_CONNECTION: 8  C   1  N  
Lk5PTCXlhLCUmyJpP0AETCjAnqCk1Q36PEdJSC3N9ODkebt2PVLsRC3eXoDUAj79PSUaUCHHy8C03Ud+PYvSVCfumbCU9i9BQH5wUCPta5BkFB9DQaIfWCDkehCUS+BCQF4bTCHeFWC03mZyvLnmSCDkZaCklM1AQbe8UCrJfJD0rHG3PouPUCj4PXDUFl/BQ teststruct_0011
Lsl4RCfaQRD0DGOsv6E+QCXYLxDEPry2vvniPC7BNpDUAwluvm6wOCz2mDEUGL3ova4BRCLUWxDkL7zBwv9XSCT/3+DkVUHEwtgWSCvVm+D0dXGJw25pTCr8HGE0saQKwqAVSCnZV8CUBVF4vOxRRCLCPIEkdi3wvPZzQCLnaRDUNUUDwzSRQCP8gDE0LHYDwYmnSCPShPE070uCw5jJTC/6BpD00buCwH8HSCrCaeD0T0zJwWykRCP1HKE0w8zJwjSmTCXs0FEkBgRMwzo3TCX1IVEUnDpJw8dYUCbPH4D0kCpJw teststruct_0011
Lc1MPCbolADkToUov434NCLmx0CkZkLoPBE2MCz+V0CUq3q1vAkYMCfIZSCU3+L6vRc8NC/Q1ICEM032PMBnMCnDz2B0OmP8P5ezLC3t6WCEf5Y+PTIaMC3kgrA0CWu9Pfi3PCDvTpCkMhLvvXulNC7nZMD06x/3PfcsOCn7PJC0h9w9PrBQOCDgmhBkpk1kP teststruct_0011
LNdeMC/WTaDEO/m6vcNgLCXxWeDkEhnBw/oDMC7swKDUFwsGwrVGNC7vPYDEhcWIwTjILCbHoGEklfjCwHfEKC71GKEEF80GwlGtJCnuphEkszUHwApqICjwUlE0dovJw1U4MCvID1DkGk12vuohKCLR4PDEdNhAwbJxKCH2mNEUU3q9vmeBMCrbiPE0kFvDwQRcKCrPaEEUYjVJwSQLJC3BCBE0ZUzFwq8UJCrIenEUP5fDwX9lKCTD2qEEX9LIwJ+cICDdG1EUDP2JwFrAJCrLQgEkeRiLwRH1HCHgHdEEl/QJw teststruct_0011
LBQZLCraTqCUpigIwm12LCX/cXC0bwALw558MCnjjtB0sffKw5pjNCnF6LBEaHXMwMosKC3kPCCU2dgMwVlpJCXpMiC0/FdNwvt+JC34FHDEk4vNwb5hICP8ZVC0mB4NwJ1jKC/+oeCEKVRHwIsLMCbeExCkWCYMwGvNKCn9xVBUmNNLwaUFLCfxCiB0lWPOw teststruct_0011
LpSNNCzxmbB0fC5HwSaQOCPilfAkDJXGwwplPCDZMNBks4lFwpUtPC3ZXDCkFiQCw8n3NC/ozf/Dx3PBwSzoMCDo9c9TnzyBwxvUMC76xW4DKTJ5vWV3LCPwiL+jJ8NbvmQqMC/DN4B0kRAFwh7XOCjifh/zNsxIwrWrNCDU8dA0L4H8vCysOCfsPP+Tdy7/vnszMCvOb23jDj6EwR+xLCLCk8+zBs7Cwy5NNCTNc867I3l0vltiLCLq0X878Jg6visqLCTKyT8j5OK0PYtBLCTa7H/joyvsv5klMCza2i/DSC5bP teststruct_0011
L7nlQCjIPzA0USWIwPM3RC7pjgBEhcbIwmGfSCvEXmBk/zTDwBh8SCbmMVCk+LpBwKT1SCLoC0A0mCWKwwHeSCH1TBBExfRNwpVrRCnj14B0VI1Nwua/SCrBzTAkhO7OwJkdQCPxk9/jAHgJwHGtRCP4aQCUHURJwCG2SCT3Gf/DpZ7JwA51TCrhNMBEmtAKw teststruct_0011
LJBTSC/aImAUo7CAwEd2SCjsglAE+amyv1a9RCLY0WBEqQupPw6IRCLWPxAECxE4PFoCTC/0MT+zlm/iv7KwTCbMLE+TVzW5PSvNVCfME4+zgFd4PcB3VCXSJJ/jLJkBQADxRCn6Km/TIxUBwf80TCv5hEB0qn+yvghnTCv8aW8TOeg2v6ZESCvFaq8jKQAavwjsTCDBCUsD2mL8P4uQTCP1cW/D4dM/PjdSVCbpLZAk+ekwPpcwVCbZCw8DkVavPg40WCftkr/zh6FBQwE0VCfY6v8zIygDQ1LYVCPCvRAU88tDQ teststruct_0011

[END 3: teststruct_0011]
[BEGIN 4: teststruct_0014]
SEQUENCE: TXDXDXDX
SCORE:     score     fa_atr     fa_rep     fa_sol    fa_intra_rep    fa_intra_sol_xover4    lk_ball_wtd    fa_elec    pro_close    hbond_sr_bb    hbond_lr_bb    hbond_bb_sc    hbond_sc    dslf_fa13      omega     fa_dun    p_aa_pp    yhh_planarity        ref    chainbreak    rama_prepro     description
REMARK BINARY SILENTFILE
ANNOTATED_SEQUENCE: T[DTHR]X[DORN]DX[DORN]DX[ORN]DX[ORN] teststruct_0014
NONCANONICAL_CONNECTION: 8  C   1  N  
LchSTCLy/PCUC7rjPvbLTCTEzzCEbK54P1iPSCjvJWD05fJxPRP1RCbXCzDESFa6PpxjUC/RiHDEt6O7PfCIVCL2xXDEIgGkP5mfVC3zLmCEwM//PpojTCTawVC0iLZ0vudxSC785nCUFtNAQlocUCTY5hDEt3bAQNyiUCvdLtDE2hgjvYtdWC3Qt0CU/7yAQ2jEVCfQCaCkxstDQ2enVC/t4LCUEpW6P teststruct_0014
LVM6RC7V1SD0NLYzvmm+QCvRmwDk/Kt6vYJjPCXijoDUTv71vGmwOCzcNDEUffrzvA2DRCzXMtDEOocDwgWZSCLeA7D0MozFwcRYSCfSo4D0VT8JwsaqTCH6tDEUnWILwe4TSCrME7CEhvH6vhWQRCHydIE0NaT4v/M4QCv/LMDUfOqEwV/RQC7pcAEUL4PFwkRnSCnw5NEE9FmEwC9LTCj5SmDEF0SEwS1MSCXOrXD0QRkKwOpkRCvUSGEU+rtKw/FnTCPFsCE0kOJNwAP1TCPnETEkpGmKwdwaUCv720DU5bdKw teststruct_0014
LIUOPCL1CAD03LIyvZf5NCnuI0CUM27hvJA5MCbMEzCk0gY6v2TcMCDV4QCEOhs9vZP8NC3ZdICUhElwPVZlMC3pD1B0RVl4P2FvLC3GhVCEy475P+MaMCX9EqAk4Ae6PFY6PCzb6oC0Kdm0vKhkNCbE+LDke3HxPKkpOCLfiJC0Ll66PA9SOCncsgBEqMuiv teststruct_0014
LediMCnsvYDEgKb+v7ZmLCfbLcDkXypDwg6LMCH1ZHDUxPTIwGHQNC7T/TDkv1PJwwEQLC79eFE01EyEwKHOKC7vqIEkWRmIwuF4JCLgNgE0wy8IwD73ICbjmjEkP6GLwim7MC/vtzDUOqQ7vJEnKC7fMODkoOoCwaQ3KCHj5MEkevJBwb2JMCrOJOEk0w6Fw6UnKCrIeCEE2oeKw8AUJCPyv/DEcrGIwQTeJC35gmEEYeKGwi3xKCnWIpEEIucJwYGrICrtYzEUdzRLwJgPJCTDFeEEC92MwBkBICnhpbE0k5pKw teststruct_0014
L9thLC/94mCEqddJwUtBMCTdtSCkXL5Lw64GNCjQYkBEuNPLwLGwNCzMcBBkJ+BNw744KCLzw5BEQ6aNwNB4JCv6gcCU9qiOw9DPKCvZyADk669Ow6DwICvdGQCEmi9OwSwqKCnuHcCUEzoIwMNYMCf1krCEBSSNwxsXKCfJZNBUKGGMwFTTLC3DhUBkidEPw teststruct_0014
LTwTNC7QJUBEFRqIwv1VOCzOzYAkGLiHwpLqPCbU/GBET1iGwQbuPCHCeBCUkxWDwoQ5NC/qSU/jXfdCw90pMCDPKL9D3aKDw8WRMCPAJX3TAa67vldzLCPnrJ+Tv1yuvftuMCLfmxB0IakGwiDgOCH6kS/TTAVJw18rNCHfwYAUiap+vE7sOCbNNC+zSvCBwv81MCnqwP0DqGNGwxk0LCzJC1+zwGfEw/lINC/7sd77ubw4vrReLCvq3c87JIb9vG3jLCLNkU8D52RsPDk/KCv11I/z2O80vXniMCroXe/z/mcov teststruct_0014
LHQtQCvszqAUphpIwLW/RCPvMXB0qplIwMthSCHaydBE9QfDwKVLTCzwSOC0BXDCwioATCPALpA0HEXKwZXvSC7/M1AEgYVNwoq9RCrpVsBUduAOwUCUTCTiJHAkHk5OwDPnQC3Vkq/zUAxJwHt3RCXxmLC0VWeJwz6/SCjcyJ/zBW6JwVsAUCvM6ABUAl6Jw teststruct_0014
L3fPSCXhheA0nSNAwaUvSC7CvcA05w5yvu1uRC7zEEBE7HCpPc+8QCnmmWAEzkr2PiJETCrQ/B+jp0RovdZNUC7YYA7T4ER4v3FgUCH1uD+72mcwvQ0nVCbMSV/bT5K6v69qRCLJOb/zRRiBw8EqTCLpQCBkN+JyvopLSCD7BH7DA1Zsvh5UTCbuq/9Dery0PY3GVCzaR89DEO02v9y8TCPR0m6jzIXAwWFnTCTiDT/LjCPyvc4wUCjTA99bK5dwPhMyVCfHCmAshOg2vvXdWCvuJO+LKlS5vLqYVCP6Dd/rsSABw teststruct_0014

[END 4: teststruct_0014]
[BEGIN 5: teststruct_0003]
SEQUENCE: DAXDXDDX
SCORE:     score     fa_atr     fa_rep     fa_sol    fa_intra_rep    fa_intra_sol_xover4    lk_ball_wtd    fa_elec    pro_close    hbond_sr_bb    hbond_lr_bb    hbond_bb_sc    hbond_sc    dslf_fa13      omega     fa_dun    p_aa_pp    yhh_planarity        ref    chainbreak    rama_prepro     description
REMARK BINARY SILENTFILE
ANNOTATED_SEQUENCE: D[DASP]A[DALA]X[ORN]D[DASP]X[ORN]DDX[ORN] teststruct_0003
NONCANONICAL_CONNECTION: 8  C   1  N  
LGtBTCrIiaCkdTHjPGOxSCrBW9C0Xf44PtNyRCHdidDkdXdwPXGhRC/70+D0XnC5P7tEUC/ZDUDk0H27PodDVCvBD3CUBg2AQO4nUCHvCfCE2aOEQ+WOWCrML5CUB7X/PThQTCrJlhC0MTj0vrmVSC3K3vCkG8EAQ4bjUC7iCgDk9IOxPIn2TC/vjvDkOSdAQ teststruct_0003
Lb1PRCvLaTD0nKVyv9bSQCjIYvDkvpe6vyXDPCbxc2DUtmOuvLEdOCrabMEEPC3uv7E5PCPn3cDkPFpCw4pgRCLNn3CEyUt4vH6wQC3JLHEU05u7vIPLPCPTHyD0UBlEwuwxQCL1uZDE1zJFw3EcPCbSh9CE4eECw teststruct_0003
LjQrOC7zqVD0J1AqPR6jNCH2GZDkff95PBhPMC/stNDkWLHxPElqLC7U9rCUL7R1PhlyNC7eS8CkYv1BQqwCPCrN3GD0DrCFQbmIPC3OsrCklfCJQqjIPCfIO6BER7aIQ+KLPCnwp5CEqmZnPYDgNC37F6DEkbw8PtY3NCLxEbCknciAQy27MCfck+Cko4hEQ6vBPCvWkoDk4ALGQBN7PCX8GBDEoflCQQUSOCjjuyC0eqVKQ5VDQCTzazC0UGHKQ4hMPCPZeYB067IKQFP7PCreHsBUfXfGQv5ROCbMvqBUZh6GQ teststruct_0003
LrVxLCHEIqDESSlpvOvfKCHM4jDEWup3viAqKCjtvDD088ZAwBBMLC7RDOD0J3pEwNn9JCLoGHEU4YR8v4YlICrm7EEkTpqAwH2GICHUgmDEIyFBwfZBICjC+UEU1oJCwS2TMCT8XCE0yf1vvaosJC/w9ZDUZ1novHE6JCbM4SEExBtzvJ4pKCXxQNEEzrIBw teststruct_0003
LoaNKCzPnbCkpDa/vOzYKCP9E2BEyi0DwaWkLCXCp8A0nsfCwXS9LCTkQGAkh5sFwGfHJCfTiABEgOdEwaI2HCnhz0BUIHOFwjv6HCzAiVC0KfIJw7KtGCnumwC0hfeJwGbvJCzIuTC0Iuh4vykfKC3KpKC0cwvHwV2+ICjoWYA02p7AwRNOJCTFNWA01c5Hw43sHCf3WPCkF7xBwIX/GC7C5JBEubgFwhFBIC78uACEJ63KwGryICvcUqCEOYCJwKvyGC/uECDEVuKLwiKnGCDRcEDEqGyHwz44FCzutdCE9omJw teststruct_0003
LE9IMCLTxIB0FFh7vHISNCz4/VAEwdC4v+7lOCLEj9Ak9tz7vhw9OC74vBCEkBY4v53SNCXvaNAU2YUwPPTaOCPiLn+jetN4P5/NPCHEmj9zUxxmPSecOCHwVF+jya0AQsZxLCTwR2BkMnL1v3yMNCDfrs+zBch7vEvVMC/1Qn/jStt1PwXaNCXTgMBEAZi3P teststruct_0003
LGeSPCfUbQA0yocBwVmdQCXcxzAE4SHEwjFfRC7FzTBUQTEAwBSMSCHfKJCkvwDBw/zGRCP5Ph/zCKwHwHfSQCvgh9+T2lYKwJyZPC7c7PA0L29KwKujQC73hA8jjYsLwx0/OC/APo+jHRUCwpeJQCHT7nBUjoyGwAtORCTVtT9TAKjFwyWGSCDJOGAk6UeIw teststruct_0003
LSlbRCHq3hAk15L1vbxUSCrxnzAECtapPuJpRCXTkrBU27t6PXfHRCfyiLB0heVBQVkzSCjFSA/zhM62PT2yTC3FFY/zvOTAQ0+HVCD4qOA0NTl8P5p/VCbtOsAknOwCQEguQCzr9n/jFVmzvtfMTCDg9VBEI+tavaKSTC7Vmh9TtpHjPjx8RCPPpy9jDOi6Pbu9TCnmB78zYnRCQ2XYTC3ZlYAkp3NDQrg8UCHmWEBkybY2P1mpVCTtf5+DWOL4P3X3WC/UpCBUAeQBQKtLWCj2h1/jQwPFQpvhVCHkWbB0umyEQ teststruct_0003

[END 5: teststruct_0003]
[BEGIN 6: teststruct_0009]
SEQUENCE: DXDXDXDX
SCORE:     score     fa_atr     fa_rep     fa_sol    fa_intra_rep    fa_intra_sol_xover4    lk_ball_wtd    fa_elec    pro_close    hbond_sr_bb    hbond_lr_bb    hbond_bb_sc    hbond_sc    dslf_fa13      omega     fa_dun    p_aa_pp    yhh_planarity        ref    chainbreak    rama_prepro     description
REMARK BINARY SILENTFILE
ANNOTATED_SEQUENCE: D[DASP]X[DORN]DX[DORN]DX[ORN]DX[ORN] teststruct_0009
NONCANONICAL_CONNECTION: 8  C   1  N  
LdNPTCvE7NCUqjLoP05DTCzAhuCUjpR6PK9NSCDRpTDEMRW0Ptj4RCb99wDUcnL8PFyaUCL9K/CkGyG+PIiPVCfSJdCE9A6BQu3qUCP6/DC0MlxEQD+bWCXQocCESMMBQbtcTC/hGXCUTECzvnDjSCnyCgCEBWiAQFQ/UCfY+KDEY8j2PUHRUCDzAaDUIgxBQ teststruct_0009
LOI4RCLhMSDUN4Mwvm2/QCvwKyDE0B34vFtjPCPnNsDEtMSyvIDzOCXBhFEEN4vwvEhERCHHIwDEFSiCwmsbSCTUi7D0J02EwHObSC3O44DkO2dJw21vTCznHCE0ngoKwuFPSCrOU6CE3Zu4vsMVRCHw0IEEDBc0vAU0QC7K7PDEK+3Dw/eVQCna+CE0R6PEwA6sSCTY/NEkbVqDwU0LTCf2llDEgLTDwMxKSC3saYDEFRFKw0LrRCjUXHEk9yQKwX2sTCHPDBEEVZpMwBW/TCbRPREUHxGKwZ2cUC/s3vDEUI8Jw teststruct_0009
LWJMPCvpZED0baarvP72NCbTm6CExVlhPi41MC7lP4CkZ6u3v5XWMCnjzVCEppj6vOn3NCv1SQCUJRv2PKXhMCnesFCUvlY8PyfxLC7W0iCk5Mi+PaLQMC7qKBBE5BB+PRX2PCLUUsCEYhzvvuljNCPSDUDU2JT1PUonOCzGwRC0x9r9PDmJOCvbqsBkPF8nP teststruct_0009
LQDiMC3cHdDUv3i8vAHjLCLDffDE7LkCwzNGMCbFeKDkIRkHwgfHNCf3HYDUkS3IwKWKLCvr9GEEpFuDwQLdKCbZOSEkzoO+vFgFKCbdFpE0o0lAwEcZJCjLV0E0dBQ4vGX/MCbpN4DUGpF6v7/kKCPnDRD0tAXBwMmDMCT1IQEU2tsEwTLgKCLxhHEEbQMHwjEjJC3JfJEUnGK8vdAHLCrWfSEEfzg2v0S/KCHh9xE0M/nBwpMbJCDp9oEEcrDEwh0KJC71ZDFE7ph6vzIjICDoasEUhhs0vWYAKCXQ00EkoCdmv teststruct_0009
LOHdLCvqjoC0sW0Iwkm7LCXJkTCkYjPLwVZ/MCv3ukBEjBlKwt5jNC/Dq8A0qbXMwWcxKCvUo8BkgRvMwW4xJCXkfeC0a13NwQnKKCXdXCD0ShVOwDOpIC/A5SC0x3QOw9CoKCzPSdCkM0zHwD8SMCf15rCU9GqMwJePKCL6mRBU17YLw8mKLCzaGWBUcMYOw teststruct_0009
LXXQNCHRHZBEKAAIw60SOCXVMeA0toNGwNeoPC3jsLBUyPnFwzvvPC37RFCUQOrCw3V5NCXsbo/Dt66AwsxpMCrzow9TMsPBw7IVMCHztf6DGza3v9B7LCjwSq+TLIrSPRQuMCv335BU6uPFwZCaOC7gEY/zhhmIwcptNCztmlA04t27vN8tOC7vRZ+zPw8+vEC0MCr82W4j7BLEwodzLCbzYF/jNZiCwvSNNCnOXe5r8XbxvhKhLCfakP7rrwp4vU5tLC3w2f9z2it2PtVGLCDmgo/ThsIpvUFrMCrsD//DAtKjP teststruct_0009
L/OpQCDHprAUEVNIwCH8RCzQbWBkRFVIwmliSCH31gBUUPGDw3vFTC3eCSCUSpxBwI/5SCj6VkAU+QHKwLHlSCHofsA0a9ENwnU0RCfHNkBkiexNwzJGTCLN41/zxfnOwM3gQCXweo/DryNJw0W0RCP5iKC0YdTJwNW4SCXdoB/zjRkJwdF7TCjuJ7A0bHyJw teststruct_0009
L9cSSCvKwjA09CN/vF0zSC3g3mAUkeowvZ16RCXgGdBkMNjrPGMERCXek7AkHHn4PAg8SCLhBZ+zQjcQP2slTCHLSR+jb3S7PiKEVC7Oy/+TXty6PjZpVCjCjZ/zrL0CQwauRCzDfi/jCCvAwDOzTCjw9DBU2bCxvg1iTC/KrV8jjYSyvla9RCPxL88T8RQdPuQfTC3lYC4j+Ki+PGMFTCXLEq/DVxUAQMJMVCbytaA0KeZ0PNXnVCTXez8jEel1Pa/nWCbJE4/jDbeCQ7ajVCTJRZ9DZq9EQ2GKVCfItcA0mPsEQ teststruct_0009

[END 6: teststruct_0009]
End full poses at pareto front
```

### Named values produced

The ParetoFront ensemble metric does not produce any named values.

##See Also

* [[SimpleMetrics]]: Available SimpleMetrics.
* [[EnsembleMetrics]]: Available EnsembleMetrics.
* [[CentralTendency ensemble metric|CentralTendency]]: An ensemble metric that computes the mean, median, mode, standard deviation, etc. for a simple metric over an ensemble of poses.
* [[I want to do x]]: Guide to choosing a tool in Rosetta.