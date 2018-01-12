import os
import click
from subprocess import call


@click.command()
@click.argument('cmd', nargs=-1)
@click.option('--flux/--no-flux', default=False)
@click.option('--account', '-a')
@click.option('--ppn', '-p', default=8)
@click.option('--mem', '-m', default='20gb')
@click.option('--walltime', '-w', default='2:00:00')
def runner(cmd, flux, account, ppn, mem, walltime):
    """ Minimalist dRep runner """
    cmd = ' '.join(cmd)
    full_dp = os.path.dirname(os.path.abspath(__file__))
    activate = 'source {} && source activate py3'.format(os.path.join(full_dp, 'dependencies/miniconda/bin/activate'))

    if flux:
        qsub = 'qsub -N omics_16s -A {} -q fluxm -l nodes=1:ppn={},mem={},walltime={}'.format(account, ppn, mem, walltime)
        call('echo "{} && {}" | {}'.format(activate, cmd, qsub), shell=True)
    else:
        call('{} && {}'.format(activate, cmd), shell=True)


if __name__ == "__main__":
    runner()
