import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { RouterModule } from '@angular/router';
import { routesRuben } from './ruben.routes';
import { RubenComponent } from './components/ruben-component/ruben.component';

@NgModule({
  imports: [CommonModule, RouterModule.forChild(routesRuben)],
  declarations: [RubenComponent],
})
export class RubenModule {}
