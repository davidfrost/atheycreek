<?php

require_once TOOLKIT . '/class.datasource.php';

class datasourcetext_entries_by_tag extends SectionDatasource
{
    public $dsParamROOTELEMENT = 'text-entries-by-tag';
    public $dsParamORDER = 'desc';
    public $dsParamPAGINATERESULTS = 'no';
    public $dsParamLIMIT = '20';
    public $dsParamSTARTPAGE = '1';
    public $dsParamREDIRECTONEMPTY = 'no';
    public $dsParamREQUIREDPARAM = '$pt1:home';
    public $dsParamSORT = 'system:id';
    public $dsParamHTMLENCODE = 'yes';
    public $dsParamASSOCIATEDENTRYCOUNTS = 'no';

    public $dsParamFILTERS = array(
        '148' => '{$ds-tags-filtered.system-id:43}',
        '209' => 'no',
    );

    public $dsParamINCLUDEDELEMENTS = array(
        'content: formatted'
    );

    public function __construct($env = null, $process_params = true)
    {
        parent::__construct($env, $process_params);
        $this->_dependencies = array('$ds-tags-filtered.system-id');
    }

    public function about()
    {
        return array(
            'name' => 'Text: Entries by tag',
            'author' => array(
                'name' => 'Jonathan Simcoe',
                'website' => 'http://atheycreek.dev',
                'email' => 'jonathan@simko.io'),
            'version' => 'Symphony 2.5.0beta2',
            'release-date' => '2014-08-11T18:14:50+00:00'
        );
    }

    public function getSource()
    {
        return '7';
    }

    public function allowEditorToParse()
    {
        return true;
    }

    public function execute(array &$param_pool = null)
    {
        $result = new XMLElement($this->dsParamROOTELEMENT);

        try{
            $result = parent::execute($param_pool);
        } catch (FrontendPageNotFoundException $e) {
            // Work around. This ensures the 404 page is displayed and
            // is not picked up by the default catch() statement below
            FrontendPageNotFoundExceptionHandler::render($e);
        } catch (Exception $e) {
            $result->appendChild(new XMLElement('error', $e->getMessage() . ' on ' . $e->getLine() . ' of file ' . $e->getFile()));
            return $result;
        }

        if ($this->_force_empty_result) {
            $result = $this->emptyXMLSet();
        }

        if ($this->_negate_result) {
            $result = $this->negateXMLSet();
        }

        return $result;
    }
}