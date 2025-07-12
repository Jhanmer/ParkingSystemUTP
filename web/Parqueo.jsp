<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="nav.jsp" />
    <style>
        :root {
            --primary: #2c3e50;
            --secondary: #3498db;
            --available: #2ecc71;
            --occupied: #e74c3c;
            --selected: #f1c40f;
            --aisle: #95a5a6;
            --road: #7f8c8d;
            --text-dark: #34495e;
            --text-light: #ecf0f1;
        }
        .parking-grid {
            width: 100%;
            display: flex;
            flex-direction: row;
            align-items: stretch; /* Cambiado a stretch */
            justify-content: flex-start;
            gap: 0;
            min-height: 420px; /* Ajusta según tus filas */
        }
        .parking-rows {
            display: flex;
            flex-direction: column;
            gap: 10px;
            flex-grow: 1;
            align-items: stretch; /* Cambia a stretch */
            width: 100%;
        }
        .parking-row {
            display: flex;
            gap: 5px;
            flex-wrap: wrap;
            width: 100%;
            justify-content: center; /* Centra los spots en la fila */
        }
        .entrance-exit {
            width: 60px;
            min-width: 60px;
            height: 220px; /* Más corto */
            background-color: var(--secondary);
            color: white;
            display: flex;
            align-items: center;
            justify-content: center;
            writing-mode: vertical-rl;
            text-orientation: mixed;
            font-weight: bold;
            border-radius: 12px;
            font-size: 1.05rem;
            margin-left: 18px;
            margin-top: 0;
            box-shadow: 0 2px 8px rgba(44,62,80,0.08);
            letter-spacing: 1px;
            transition: height 0.2s;
        }
        .parking-spot {
            width: 40px;
            height: 60px;
            flex: 1 1 40px; /* Permite que se adapten */
            max-width: 60px;
            min-width: 28px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: bold;
            cursor: pointer;
            border-radius: 4px;
            transition: all 0.2s;
            position: relative;
            overflow: hidden;
            font-size: 12px;
        }
        .spot-number {
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            font-size: 12px;
            font-weight: bold;
            color: inherit;
        }
        .available {
            background-color: var(--available);
            color: var(--text-dark);
            border: 1px solid #27ae60;
        }
        .occupied {
            background-color: var(--occupied);
            color: var(--text-light);
            cursor: not-allowed;
            border: 1px solid #c0392b;
        }
        .selected {
            background-color: var(--selected);
            color: var(--text-dark);
            transform: scale(1.05);
            box-shadow: 0 0 0 2px var(--secondary);
            border: 1px solid #f39c12;
        }
        .aisle {
            background-color: var(--aisle);
            min-width: 20px;
            cursor: default;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-weight: bold;
        }
        .road {
            background-color: var(--road);
            height: 40px;
            width: 100%;
            margin: 15px 0;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.3rem;
            font-weight: bold;
            color: #fff; /* Mejor contraste */
            letter-spacing: 2px;
            border-radius: 6px;
        }
        .controls {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
            flex-wrap: wrap;
            gap: 10px;
        }
        .legend {
            display: flex;
            gap: 15px;
            flex-wrap: wrap;
        }
        .legend-item {
            display: flex;
            align-items: center;
            gap: 5px;
            font-size: 14px;
        }
        .legend-color {
            width: 20px;
            height: 20px;
            border-radius: 3px;
        }
        button {
            background-color: var(--secondary);
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 5px;
            cursor: pointer;
            font-weight: bold;
            transition: background-color 0.2s;
        }
        button:hover {
            background-color: #2980b9;
        }
        button:disabled {
            background-color: #95a5a6;
            cursor: not-allowed;
        }
        .selection-info {
            background-color: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            margin-top: 20px;
        }
        @media (max-width: 768px) {
            .parking-spot {
                width: 30px;
                height: 45px;
                font-size: 10px;
            }
            .spot-number {
                font-size: 7px;
            }
        }
        @media (max-width: 900px) {
            .parking-grid {
                flex-direction: column;
                align-items: stretch;
                min-height: unset;
            }
            .entrance-exit {
                width: 100%;
                min-width: unset;
                height: 50px;
                writing-mode: horizontal-tb;
                text-orientation: initial;
                font-size: 1rem;
                margin: 0 0 10px 0;
                border-radius: 8px;
                justify-content: flex-start;
                padding-left: 20px;
            }
            .parking-rows {
                align-items: stretch;
            }
            .parking-row {
                gap: 3px;
            }
            .parking-spot {
                width: 28px;
                height: 40px;
                font-size: 10px;
                min-width: 18px;
                max-width: 40px;
            }
        }
    </style>
    <div class="content-wrapper">
        <div class="container-xxl flex-grow-1 container-p-y">
          <div class="container-xxl flex-grow-1 container-p-y">
            <h1 class="mb-4 text-center" style="color: var(--primary); font-weight: bold;">Mapa Actual del Estacionamiento</h1>
            <div class="controls mb-4">
              <div class="legend">
                <div class="legend-item">
                  <div class="legend-color" style="background-color: var(--available);"></div>
                  <span>Disponible</span>
                </div>
                <div class="legend-item">
                  <div class="legend-color" style="background-color: var(--occupied);"></div>
                  <span>Ocupado</span>
                </div>
                <div class="legend-item">
                  <div class="legend-color" style="background-color: var(--selected);"></div>
                  <span>Seleccionado</span>
                </div>
                <div class="legend-item">
                  <div class="legend-color" style="background-color: var(--aisle);"></div>
                  <span>Pasillo</span>
                </div>
                <div class="legend-item">
                  <div class="legend-color" style="background-color: var(--road);"></div>
                  <span>Carril</span>
                </div>
              </div>
              <button id="confirmBtn" onclick="confirmSelection()" disabled>Confirmar Selección</button>
            </div>
            <div class="parking-grid">
                <div class="parking-rows">
                    <div class="road">CARRIL</div>
                    <!-- Fila 1 -->
                    <div class="parking-row">
                      <div class="parking-spot available" data-spot="1"><span class="spot-number">1</span></div>
                      <div class="parking-spot available" data-spot="2"><span class="spot-number">2</span></div>
                      <div class="parking-spot available" data-spot="3"><span class="spot-number">3</span></div>
                      <div class="parking-spot available" data-spot="4"><span class="spot-number">4</span></div>
                      <div class="parking-spot available" data-spot="5"><span class="spot-number">5</span></div>
                      <div class="aisle">↕</div>
                      <div class="aisle">↕</div>
                      <div class="parking-spot available" data-spot="6"><span class="spot-number">6</span></div>
                      <div class="parking-spot available" data-spot="7"><span class="spot-number">7</span></div>
                      <div class="parking-spot available" data-spot="8"><span class="spot-number">8</span></div>
                      <div class="parking-spot available" data-spot="9"><span class="spot-number">9</span></div>
                      <div class="parking-spot available" data-spot="10"><span class="spot-number">10</span></div>
                      <div class="aisle">↕</div>
                      <div class="aisle">↕</div>
                      <div class="parking-spot available" data-spot="11"><span class="spot-number">11</span></div>
                      <div class="parking-spot occupied" data-spot="12"><span class="spot-number">12</span></div>
                      <div class="parking-spot available" data-spot="13"><span class="spot-number">13</span></div>
                      <div class="parking-spot available" data-spot="14"><span class="spot-number">14</span></div>
                      <div class="parking-spot occupied" data-spot="15"><span class="spot-number">15</span></div>
                      <div class="aisle">↕</div>
                      <div class="aisle">↕</div>
                      <div class="parking-spot available" data-spot="16"><span class="spot-number">16</span></div>
                      <div class="parking-spot available" data-spot="17"><span class="spot-number">17</span></div>
                      <div class="parking-spot available" data-spot="18"><span class="spot-number">18</span></div>
                      <div class="parking-spot occupied" data-spot="19"><span class="spot-number">19</span></div>
                      <div class="parking-spot available" data-spot="20"><span class="spot-number">20</span></div>
                      <div class="aisle">↕</div>
                      <div class="aisle">↕</div>
                    </div>
                    <div class="road">CARRIL</div>
                    <!-- Fila 2: 21-40 -->
                    <div class="parking-row">
                      <div class="parking-spot available" data-spot="21"><span class="spot-number">21</span></div>
                      <div class="parking-spot available" data-spot="22"><span class="spot-number">22</span></div>
                      <div class="parking-spot available" data-spot="23"><span class="spot-number">23</span></div>
                      <div class="parking-spot available" data-spot="24"><span class="spot-number">24</span></div>
                      <div class="parking-spot available" data-spot="25"><span class="spot-number">25</span></div>
                      <div class="aisle">↕</div>
                      <div class="aisle">↕</div>
                      <div class="parking-spot available" data-spot="26"><span class="spot-number">26</span></div>
                      <div class="parking-spot occupied" data-spot="27"><span class="spot-number">27</span></div>
                      <div class="parking-spot available" data-spot="28"><span class="spot-number">28</span></div>
                      <div class="parking-spot available" data-spot="29"><span class="spot-number">29</span></div>
                      <div class="parking-spot available" data-spot="30"><span class="spot-number">30</span></div>
                      <div class="aisle">↕</div>
                      <div class="aisle">↕</div>
                      <div class="parking-spot available" data-spot="31"><span class="spot-number">31</span></div>
                      <div class="parking-spot occupied" data-spot="32"><span class="spot-number">32</span></div>
                      <div class="parking-spot available" data-spot="33"><span class="spot-number">33</span></div>
                      <div class="parking-spot available" data-spot="34"><span class="spot-number">34</span></div>
                      <div class="parking-spot occupied" data-spot="35"><span class="spot-number">35</span></div>
                      <div class="aisle">↕</div>
                      <div class="aisle">↕</div>
                      <div class="parking-spot available" data-spot="36"><span class="spot-number">36</span></div>
                      <div class="parking-spot occupied" data-spot="37"><span class="spot-number">37</span></div>
                      <div class="parking-spot available" data-spot="38"><span class="spot-number">38</span></div>
                      <div class="parking-spot occupied" data-spot="39"><span class="spot-number">39</span></div>
                      <div class="parking-spot available" data-spot="40"><span class="spot-number">40</span></div>
                      <div class="aisle">↕</div>
                      <div class="aisle">↕</div>
                    </div>
                    <div class="road">CARRIL</div>
                    <!-- Fila 3: 41-60 -->
                    <div class="parking-row">
                      <div class="parking-spot available" data-spot="41"><span class="spot-number">41</span></div>
                      <div class="parking-spot available" data-spot="42"><span class="spot-number">42</span></div>
                      <div class="parking-spot occupied" data-spot="43"><span class="spot-number">43</span></div>
                      <div class="parking-spot available" data-spot="44"><span class="spot-number">44</span></div>
                      <div class="parking-spot available" data-spot="45"><span class="spot-number">45</span></div>
                      <div class="aisle">↕</div>
                      <div class="aisle">↕</div>
                      <div class="parking-spot available" data-spot="46"><span class="spot-number">46</span></div>
                      <div class="parking-spot available" data-spot="47"><span class="spot-number">47</span></div>
                      <div class="parking-spot available" data-spot="48"><span class="spot-number">48</span></div>
                      <div class="parking-spot available" data-spot="49"><span class="spot-number">49</span></div>
                      <div class="parking-spot available" data-spot="50"><span class="spot-number">50</span></div>
                      <div class="aisle">↕</div>
                      <div class="aisle">↕</div>
                      <div class="parking-spot available" data-spot="51"><span class="spot-number">51</span></div>
                      <div class="parking-spot occupied" data-spot="52"><span class="spot-number">52</span></div>
                      <div class="parking-spot occupied" data-spot="53"><span class="spot-number">53</span></div>
                      <div class="parking-spot available" data-spot="54"><span class="spot-number">54</span></div>
                      <div class="parking-spot occupied" data-spot="55"><span class="spot-number">55</span></div>
                      <div class="aisle">↕</div>
                      <div class="aisle">↕</div>
                      <div class="parking-spot available" data-spot="56"><span class="spot-number">56</span></div>
                      <div class="parking-spot available" data-spot="57"><span class="spot-number">57</span></div>
                      <div class="parking-spot available" data-spot="58"><span class="spot-number">58</span></div>
                      <div class="parking-spot occupied" data-spot="59"><span class="spot-number">59</span></div>
                      <div class="parking-spot available" data-spot="60"><span class="spot-number">60</span></div>
                      <div class="aisle">↕</div>
                      <div class="aisle">↕</div>
                    </div>
                    <div class="road">CARRIL</div>
                </div>
                <div class="entrance-exit">ENTRADA/SALIDA</div>
            </div>
          </div>
        </div>
      </div>

<jsp:include page="footer.jsp" />